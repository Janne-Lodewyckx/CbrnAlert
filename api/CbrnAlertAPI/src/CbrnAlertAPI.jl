# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""
Encapsulates generated server code for CbrnAlertAPI

The following server methods must be implemented:

- **atp45_run_post**
    - *invocation:* POST /atp45/run
    - *signature:* atp45_run_post(req::HTTP.Request, weathertype::Atp45RunTypes, atp45_input::Atp45Input;) -> Atp45Result
- **atp45_tree_get**
    - *invocation:* GET /atp45/tree
    - *signature:* atp45_tree_get(req::HTTP.Request;) -> Atp45DecisionTree
- **forecast_available_get**
    - *invocation:* GET /forecast/available
    - *signature:* forecast_available_get(req::HTTP.Request;) -> ForecastAvailableSteps
- **login_post**
    - *invocation:* POST /login
    - *signature:* login_post(req::HTTP.Request, login_post_request::LoginPostRequest;) -> LoginPost200Response
- **flexpart_input_post**
    - *invocation:* POST /flexpart/input
    - *signature:* flexpart_input_post(req::HTTP.Request, flexpart_input_post_request::FlexpartInputPostRequest; retrieval_type=nothing,) -> FlexpartInput
- **flexpart_inputs_get**
    - *invocation:* GET /flexpart/inputs
    - *signature:* flexpart_inputs_get(req::HTTP.Request; status=nothing,) -> Vector{FlexpartInput}
- **flexpart_outputs_output_id_dimensions_get**
    - *invocation:* GET /flexpart/outputs/{outputId}/dimensions
    - *signature:* flexpart_outputs_output_id_dimensions_get(req::HTTP.Request, output_id::String; layer=nothing, horizontal=nothing,) -> Any
- **flexpart_outputs_output_id_get**
    - *invocation:* GET /flexpart/outputs/{outputId}
    - *signature:* flexpart_outputs_output_id_get(req::HTTP.Request, output_id::String;) -> FlexpartOutput
- **flexpart_outputs_output_id_layers_get**
    - *invocation:* GET /flexpart/outputs/{outputId}/layers
    - *signature:* flexpart_outputs_output_id_layers_get(req::HTTP.Request, output_id::String; spatial=nothing,) -> Vector{String}
- **flexpart_outputs_output_id_slice_post**
    - *invocation:* POST /flexpart/outputs/{outputId}/slice
    - *signature:* flexpart_outputs_output_id_slice_post(req::HTTP.Request, layer::String, output_id::String, body::Any; geojson=nothing, legend=nothing,) -> FlexpartOutputsOutputIdSlicePost200Response
- **flexpart_run_post**
    - *invocation:* POST /flexpart/run
    - *signature:* flexpart_run_post(req::HTTP.Request, input_id::String, flexpart_run_post_request::FlexpartRunPostRequest; run_type=nothing,) -> FlexpartRun
- **flexpart_runs_get**
    - *invocation:* GET /flexpart/runs
    - *signature:* flexpart_runs_get(req::HTTP.Request; status=nothing,) -> Vector{FlexpartRun}
- **flexpart_runs_run_id_delete**
    - *invocation:* DELETE /flexpart/runs/{runId}
    - *signature:* flexpart_runs_run_id_delete(req::HTTP.Request, run_id::String;) -> FlexpartRun
- **flexpart_runs_run_id_get**
    - *invocation:* GET /flexpart/runs/{runId}
    - *signature:* flexpart_runs_run_id_get(req::HTTP.Request, run_id::String;) -> FlexpartRun
- **flexpart_runs_run_id_outputs_get**
    - *invocation:* GET /flexpart/runs/{runId}/outputs
    - *signature:* flexpart_runs_run_id_outputs_get(req::HTTP.Request, run_id::String;) -> Vector{FlexpartOutput}
"""
module CbrnAlertAPI

using HTTP
using URIs
using Dates
using TimeZones
using OpenAPI
using OpenAPI.Servers

const API_VERSION = "1.0"

include("modelincludes.jl")

include("apis/api_Atp45Api.jl")
include("apis/api_AuthApi.jl")
include("apis/api_FlexpartApi.jl")

"""
Register handlers for all APIs in this module in the supplied `Router` instance.

Paramerets:
- `router`: Router to register handlers in
- `impl`: module that implements the server methods

Optional parameters:
- `path_prefix`: prefix to be applied to all paths
- `optional_middlewares`: Register one or more optional middlewares to be applied to all requests.

Optional middlewares can be one or more of:
    - `init`: called before the request is processed
    - `pre_validation`: called after the request is parsed but before validation
    - `pre_invoke`: called after validation but before the handler is invoked
    - `post_invoke`: called after the handler is invoked but before the response is sent

The order in which middlewares are invoked are:
`init |> read |> pre_validation |> validate |> pre_invoke |> invoke |> post_invoke`
"""
function register(router::HTTP.Router, impl; path_prefix::String="", optional_middlewares...)
    registerAtp45Api(router, impl; path_prefix=path_prefix, optional_middlewares...)
    registerAuthApi(router, impl; path_prefix=path_prefix, optional_middlewares...)
    registerFlexpartApi(router, impl; path_prefix=path_prefix, optional_middlewares...)
    return router
end

end # module CbrnAlertAPI
