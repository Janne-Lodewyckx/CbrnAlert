# CbrnAlert
These are the sources for the CbrnAlert application. This application first consists in a REST API for preparing, running and getting the results of atmospheric dispersion models. The documentation of this API should be available [here](https://cbrnalert.rma.ac.be/api/docs). The access to this API is restricted, but it's possible to install your proper instance of the application.

This repo also contains the sources for the Single Page Application developed with the Angular framework, which provides a GUI for calling the API.

The API is defined using the [Open API](https://www.openapis.org/) specifications. The file with all the API definitions is availabe [here](https://github.com/tcarion/CbrnAlert/blob/master/api/api_docs.yaml). From these definitions, the API routes and data structures are generated in the Angular/Typescript world with [ng-openapi-gen](https://github.com/cyclosproject/ng-openapi-gen) and in the Julia/Genie world with [OpenAPI.jl](https://github.com/JuliaComputing/OpenAPI.jl) and [OpenAPI generator](https://openapi-generator.tech/).


# Installation
This section explains how to make the app ready both for development purpose and for production. The installation is meant to be done on Rocky Linux v9 or Centos 7, but it should be easy to adapt on other Linux systems. The main softwares needed for the application is [Julia](https://julialang.org/), [nodejs](https://nodejs.org/fr), [Angular](https://angular.io/), java and [eccodes](https://confluence.ecmwf.int/display/ECC).

## Docker quickstart for development

The easiest way to develop is to use a VS Code devcontainer. Install the "Dev Containers" VS Code extension, and then after opening a clone of this repository choose to open it in a dev container. From there, start a first bash terminal and run:

```bash
cd backend
./bin/repl
```

This will start a CLI into the backend server. Once you get the julia prompt, enter:

```julia
up()
```

Next, open a new terminal and enter:

```bash
cd frontend
npm run start
```

You can now connect to http://localhost:4200 and login with login `test` and password `test`.

## Alternative : Manual Reinstall (anomaly with setup.sh)
Usually, the quickstart setup above should work. Otherwise follow these manual steps below : 

### Setup 
0/ Write API keys on a file ".ecmwfapirc" and save it as no extension file in C:/Users/YOURNAME, check if there is NO folders with the same name !

1/ In VSCode, a popup saying "Reopen in Dev Container" will appears. Click it.

2/ Open a terminal, go in backend folder , and try to run "./bin/repl". If it is not recognized, you need dos2unix to convert the file before running it again.
    
```
yum install dos2unix
dos2unix ./bin/repl
./bin/repl
```

3/ After running the repl, you will probably see a bunch of errors, this means Julia is not yet instantiated. You need to generate the files.

```
julia +1.7 --project
```
After Julia is open, enter the Julia Package Manager with "]" and write instantiate :

```julia
(CbrnAlertApp) > instantiate
```
You will probably get FlexExtract errors, go back to Julia REPL and write : 
```julia
ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")
```
Retry to instantiate julia with the "]", the FlexExtract error should be gone.

4/ Run "./bin/repl" again, the Genie S framework will appears.

5/ Write these lines in julia>, it will generate the users tables in db.sqlite
```julia
using SearchLight
using SearchLightSQLite
SearchLight.Migration.init()
SearchLight.Migration.status()
SearchLight.Migration.allup()
```
NB: (DO NOT trust setup.jl to do it for you!)


6/ Exit Julia, and write these line to generate the encoding JSON Web tokens
```
openssl genrsa -out config/private.pem 2048
openssl rsa -in config/private.pem -out config/public.pem -outform PEM -pubout
```


7/ Open a new terminal, go in frontend folder

8/ install the angular command line interface:
```
npm install @angular/cli
```

You may have a bunch of errors and that you can see with "npm audit". You can --force or adding overrides on package.json located in the frontend folder.
 
 ```
"overrides": 
{
"glob-parent":"6.0.2",
 "@angular/core":"^16.1.2",
 "axios":"1.6.5",
 "tough-cookie":"4.1.3",
 "xml2js":"0.6.2"
 }
```
Remember to use "npm update" if you change the overrides later.
This will get rid of critical and leave with "request *" vulnerability that 3 others modules depends on. I have yet to find a solution for this.


9/ install javascript libraries, similar vulnerabilities will appears but you can ignore them for now

```
npm install
```
10/ generate the OpenAPI

```
npm run generate:all
```

### Starting the App


1/ You will need an user to use the app, to create one : 
```
	cd CbrnAlert/backend
	./bin/repl
```

2/ in julia>, write this : 

```julia
	using CbrnAlertApp
	using CbrnAlertApp.Users
	Users.add("USEREMAIL", "PASSWORD", username = "USERNAME")
```
For the sake of simplicity, you can go like this for the last line :
```julia
> Users.add("test", "test", username = "test")
```
this will add an user to the SQL table, you can see it in backend/db/db.sqlite

3/ you can launch the backend server, that will listen on 8000.
```julia
	julia > up()
```
	
You should get something like this : 
```julia
	┌ Info: 2024-01-18 08:24:33 
	└ Web Server starting at http://127.0.0.1:8000 
	[ Info: 2024-01-18 08:24:34 Listening on: 127.0.0.1:8000, thread id: 1
	Genie.Server.ServersCollection(Task (runnable) @0x00007fe561b215a0, nothing)
```


4/ go to the front end server : 
```
	cd CbrnAlert/frontend
	npm run start
```

	This will launch the server on 4200. This may take a long time at first

5/ Open the Server 4200 on a browser

6/ you can now authenticate with the users you added. You can also check the users with sqlite tools, extensions or dbbrowser in the backend/db/db.sqlite file

7/ Try to monitor backend terminal activity when interacting with the app.




## Archive : Common steps for both development and production
These are tcarion's instructions for an older version of the project. You can ignore these for now.


### Credentials for the ECMWF API
The application needs to retrieve weather forecasts from ECMWF. That means you'll need to have access to licensed datasets from ECMWF. To setup your credentials, you need to go on https://api.ecmwf.int/v1/key to get your API key, and write those lines on a file called `.ecmwfapirc` in your `$HOME` folder:

```
{
    "url"   : "https://api.ecmwf.int/v1",
    "key"   : "YOUR_API_KEY",
    "email" : "YOUR_EMAIL"
}
```

### Install Julia
Due to an issue with Flexpart.jl (see [this](https://github.com/tcarion/Flexpart.jl/issues/9)), the application will only work with Julia v1.7. To easily install Julia v1.7, you can use [Juliaup](https://github.com/JuliaLang/juliaup):

```bash
curl -fsSL https://install.julialang.org | sh
```

Accept the basic configuration, restart your shell session, and install the Julia v1.7 binary with:

```bash
juliaup add 1.7
```

Now you should be able to run this julia version with:

```bash
julia +1.7
```

### Install nodejs
The app needs at least nodejs v16.

**On Rocky Linux v9**

The registry version of nodejs is should be at least v16, so it can be installed globally:

```bash
sudo yum update nodejs
```

**On CentOS 7**

On CentOS 7, nodejs is limited to v14, so we'll need to install it locally with [nvm](https://github.com/nvm-sh/nvm):


1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`
1. Uncomment NVM related lines in `~/.bashrc`
1. `chmod +x ~/.nvm/nvm.sh`
1. `source ~/.bashrc`
1. `nvm install 16` (v18 won't work because of glibc incompatibilities)

### Install Java
At the moment, Java is needed for the `openapi-generator-cli` to work properly:

```bash
sudo yum install java-11-openjdk-devel
```

### Install eccodes globally.
Unfortunately, the python program for flex_extract is executing the `grib_set` command with `subprocess.check_call()`. I couldn't find a way to make this command available in the PATH when running the python script. So `eccodes` and the `grib_*` commands must be available in the path.

```bash
sudo yum install eccodes
```

### Clone the repo

```bash
git clone https://github.com/tcarion/CbrnAlert
```

### Set up the frontend
Install the Angular command line interface:

```bash
npm install @angular/cli
```

Download and install the required javascript librairies for the frontend:
```
cd CbrnAlert/frontend
npm install
```

You might get compats error from npm, if so, retry with `npm install --force` 

### Set up the backend

Go to the backend folder and open a Julia REPL:
```
cd CbrnAlert/backend
julia +1.7 --project
```

Download the required Julia packages. You will have to enter the [Pkg REPL](https://docs.julialang.org/en/v1/stdlib/Pkg/#Pkg) by pressing `]` from the Julia REPL. Then, the following command will install all the required registered Julia packages:

```julia
(CbrnAlertApp) pkg> instantiate
```

You might get an error like that:

```julia
[ Info: Precompiling FlexExtract [5ad5ba56-8ec2-41bb-8b56-2065914898b5]
ERROR: LoadError: InitError: PyError (PyImport_ImportModule

The Python package ecmwfapi could not be imported by pyimport. Usually this means
that you did not install ecmwfapi in the Python version being used by PyCall.
```

The simplest way to overcome this is to configure PyCall to use a Julia-specific Python distribution. To do that:

```julia
ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")
```

Then restart julia, and you should be to import FlexExtract without error.

Still in the backend folder, run the `repl` scripts:

```bash
cd CbrnAlert/backend
./bin/repl
```

This will open a Julia REPL and setup the Genie environment. This may take a few minutes. Once it's done and you can write in the Julia REPL, you need to set up the database with:

```julia
using SearchLight
using SearchLightSQLite
SearchLight.Migration.init()
SearchLight.Migration.status()
SearchLight.Migration.allup()
```

### Set up the JSON Web Tokens keys
We need now to generate the keys for encoding and decoding the JSON Web Tokens authentication. Go to the backend folder and write:

```bash
openssl genrsa -out config/private.pem 2048
openssl rsa -in config/private.pem -out config/public.pem -outform PEM -pubout
```

*Note: These lines won't work with OpenSSL v1*
## Setup for development

To get the app up and ready for development, you'll need to follow those few steps.

### Run the backend server
Go to the backend folder, and run the `repl` scripts:

```bash
cd CbrnAlert/backend
./bin/repl
```

And finally start the server:
```julia
julia> up()
┌ Info: 2023-10-06 09:42:54 
└ Web Server starting at http://127.0.0.1:8000 
[ Info: 2023-10-06 09:42:54 Listening on: 127.0.0.1:8000, thread id: 1
Genie.Server.ServersCollection(Task (runnable) @0x00007f821a6e42f0, nothing)
```

You should see those lines, meaning that a server is listening on `localhost:8000`.

If you want, you can also set up a `screen` session like this (probably you will have to install `screen` with `sudo yum install screen`):

```bash
screen -S cbrnalert_backend
```
 
and then follow the above steps.

If you need to start the server again, you just need to run `repl` script and run `up()` in the Julia REPL:

```bash
./bin/repl
julia> up()
```

In case you're using `screen` you can attach to your screen session with:

```bash
screen -R cbrnalert_backend
```

### Run the frontend server
Go to the frontend folder and run this command:

```bash
cd CbrnAlert/frontend
npm run generate:all
```

This will read the [OpenAPI specifications file](https://github.com/tcarion/CbrnAlert/blob/master/api/api_docs.yaml) to generate all the files needed for both the frontend and the backend.

Finally, run the frontend server that will listen to `localhost:4200`:

```bash
npm run start
```

At this point you should be able to connect to `localhost:4200` and start using the application. If you set everything up on a remote machine, you might need to use `ssh` tunnels to redirect the application ports. When using the VS code editor, this is done automatically.

### Adding a user in the database

When getting on the app landing page, you're asked for an email and a password. That's because you need to be authenticated to use the application API. To add a new user in the database, you need to get into the Genie environment in the interactive mode:

```bash
cd PATH_TO_APP/CbrnAlert/backend
./bin/repl
```

Then you need to use the `Users.add` function:

```julia
julia> using CbrnAlertApp.Users
julia> Users.add("USER_EMAIL", "USER_PW", username = "USERNAME")
```

Now you should be able to log in into the app by using `USER_EMAIL` and `USER_PW`.

## Setup for production
We will deploy the app by using [nginx](https://nginx.org/) to serve the Angular frontend static files and proxy the API traffic to the Genie backend.

### Generate the frontend static files
Go to the frontend folder and run:
```bash
npm run build
```

This should create a `dist` folder that will be served with nginx.

### Run the API backend server
Go to the backend folder. You should install the `screen` software and create a new screen for the backend. This will allow to close the terminal while keeping the Julia server up.

```bash
screen -S genie
```

Then start the Genie server in production mode:
```bash
export GENIE_ENV=prod
./bin/server
```

### Set up nginx
First install nginx and start it to see if it work (you'll need to do all of this in `sudo` mode):

```bash
yum install nginx
systemctl start nginx
systemctl enable nginx
```

The next step is to configure nginx to serve the static files and forward the API traffic to the Genie backend. After installing nginx, you should have the default configuration in the `/etc/nginx` directory. You can add the configuration for the application by creating a new configuration file:

```bash
touch /etc/nginx/conf.d/YOUR_DOMAIN.conf
```

where `YOUR_DOMAIN` is the domain name you want to deploy. Then writing the following configuration in this file should do the trick:

```nginx
server {
    server_name YOUR_DOMAIN;

    root PATH_TO_APP/CbrnAlert/frontend/dist;

    location /api {
        proxy_pass http://localhost:8000;
    }

    location /api/docs {
        proxy_pass http://localhost:8000/docs;
    }
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

Now, for having a secured communication with HTTPS, we can use [certbot](https://certbot.eff.org/) and [Let's Encrypt](https://letsencrypt.org/) to get the certificates. First, you need to install `certbot` with:

```bash
sudo yum install certbot python3-certbot-apache
```

and to get the Let's Encrypt certificates:

```bash
sudo certbot --nginx -d YOUR_DOMAIN
```

`certbot` should have modified your configuration file that should look like this now:

```nginx
server {
    server_name YOUR_DOMAIN;

    root PATH_TO_APP/CbrnAlert/frontend/dist;

    location /api {
        proxy_pass http://localhost:8000;
    }

    location /api/docs {
        proxy_pass http://localhost:8000/docs;
    }
    
    location / {
        try_files $uri $uri/ /index.html;
    }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/YOUR_DOMAIN/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/YOUR_DOMAIN/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = YOUR_DOMAIN) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80 default_server;
    listen [::]:80 default_server;
    
    server_name YOUR_DOMAIN;
    return 404; # managed by Certbot
}
```

You'll also need to open the port of the server machine to the world:

```bash
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --reload
```

If the machine uses SELinux, you might have a problem with connecting to the backend API. This can be solved with:

```bash
setsebool -P httpd_can_network_connect 1
```

Now, you should get the application landing page when you connect to your domain with a browser. However, it's possible that SELinux blocks the access of nginx to the `PATH_TO_APP/CbrnAlert/frontend/dist` folder. This can be solved by changing the context of this folder:

```
sudo find PATH_TO_APP/CbrnAlert/frontend/dist/ -exec chcon -t httpd_sys_content_t {} \;
```

After all that, your instance of the application should be accessible on the Internet! Please open an issue if it's not the case. Don't forget that you'll need to add a new user to be able to connect (see the "Adding a user in the database" section).
