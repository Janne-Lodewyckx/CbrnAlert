# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Describe the ATP45 categories that will determine which case needs to be considered.

    Atp45Category(;
        id=nothing,
        description=nothing,
        note=nothing,
        longname=nothing,
        paramtype=nothing,
        internalname=nothing,
        content=nothing,
    )

    - id::String
    - description::String
    - note::String
    - longname::String
    - paramtype::String
    - internalname::String
    - content::Vector{String}
"""
Base.@kwdef mutable struct Atp45Category <: OpenAPI.APIModel
    id::Union{Nothing, String} = nothing
    description::Union{Nothing, String} = nothing
    note::Union{Nothing, String} = nothing
    longname::Union{Nothing, String} = nothing
    paramtype::Union{Nothing, String} = nothing
    internalname::Union{Nothing, String} = nothing
    content::Union{Nothing, Vector{String}} = nothing

    function Atp45Category(id, description, note, longname, paramtype, internalname, content, )
        OpenAPI.validate_property(Atp45Category, Symbol("id"), id)
        OpenAPI.validate_property(Atp45Category, Symbol("description"), description)
        OpenAPI.validate_property(Atp45Category, Symbol("note"), note)
        OpenAPI.validate_property(Atp45Category, Symbol("longname"), longname)
        OpenAPI.validate_property(Atp45Category, Symbol("paramtype"), paramtype)
        OpenAPI.validate_property(Atp45Category, Symbol("internalname"), internalname)
        OpenAPI.validate_property(Atp45Category, Symbol("content"), content)
        return new(id, description, note, longname, paramtype, internalname, content, )
    end
end # type Atp45Category

const _property_types_Atp45Category = Dict{Symbol,String}(Symbol("id")=>"String", Symbol("description")=>"String", Symbol("note")=>"String", Symbol("longname")=>"String", Symbol("paramtype")=>"String", Symbol("internalname")=>"String", Symbol("content")=>"Vector{String}", )
OpenAPI.property_type(::Type{ Atp45Category }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_Atp45Category[name]))}

function check_required(o::Atp45Category)
    o.id === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ Atp45Category }, name::Symbol, val)
end
