# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""A tree of &#x60;Atp45Category&#x60;, representing the decision sequence leading to the final ATP45 case.

    Atp45DecisionTree(;
        id=nothing,
        description=nothing,
        note=nothing,
        longname=nothing,
        paramtype=nothing,
        internalname=nothing,
        content=nothing,
        children=nothing,
    )

    - id::String
    - description::String
    - note::String
    - longname::String
    - paramtype::String
    - internalname::String
    - content::Vector{String}
    - children::Vector{Atp45DecisionTree}
"""
Base.@kwdef mutable struct Atp45DecisionTree <: OpenAPI.APIModel
    id::Union{Nothing, String} = nothing
    description::Union{Nothing, String} = nothing
    note::Union{Nothing, String} = nothing
    longname::Union{Nothing, String} = nothing
    paramtype::Union{Nothing, String} = nothing
    internalname::Union{Nothing, String} = nothing
    content::Union{Nothing, Vector{String}} = nothing
    children::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Atp45DecisionTree} }

    function Atp45DecisionTree(id, description, note, longname, paramtype, internalname, content, children, )
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("id"), id)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("description"), description)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("note"), note)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("longname"), longname)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("paramtype"), paramtype)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("internalname"), internalname)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("content"), content)
        OpenAPI.validate_property(Atp45DecisionTree, Symbol("children"), children)
        return new(id, description, note, longname, paramtype, internalname, content, children, )
    end
end # type Atp45DecisionTree

const _property_types_Atp45DecisionTree = Dict{Symbol,String}(Symbol("id")=>"String", Symbol("description")=>"String", Symbol("note")=>"String", Symbol("longname")=>"String", Symbol("paramtype")=>"String", Symbol("internalname")=>"String", Symbol("content")=>"Vector{String}", Symbol("children")=>"Vector{Atp45DecisionTree}", )
OpenAPI.property_type(::Type{ Atp45DecisionTree }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_Atp45DecisionTree[name]))}

function check_required(o::Atp45DecisionTree)
    o.id === nothing && (return false)
    o.children === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ Atp45DecisionTree }, name::Symbol, val)
end
