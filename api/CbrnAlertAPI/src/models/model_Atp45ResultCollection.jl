# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""
    Atp45ResultCollection(;
        type=nothing,
        bbox=nothing,
        features=nothing,
    )

    - type::String
    - bbox::Vector{Float64}
    - features::Vector{Atp45Zone}
"""
Base.@kwdef mutable struct Atp45ResultCollection <: OpenAPI.APIModel
    type::Union{Nothing, String} = nothing
    bbox::Union{Nothing, Vector{Float64}} = nothing
    features::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Atp45Zone} }

    function Atp45ResultCollection(type, bbox, features, )
        OpenAPI.validate_property(Atp45ResultCollection, Symbol("type"), type)
        OpenAPI.validate_property(Atp45ResultCollection, Symbol("bbox"), bbox)
        OpenAPI.validate_property(Atp45ResultCollection, Symbol("features"), features)
        return new(type, bbox, features, )
    end
end # type Atp45ResultCollection

const _property_types_Atp45ResultCollection = Dict{Symbol,String}(Symbol("type")=>"String", Symbol("bbox")=>"Vector{Float64}", Symbol("features")=>"Vector{Atp45Zone}", )
OpenAPI.property_type(::Type{ Atp45ResultCollection }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_Atp45ResultCollection[name]))}

function check_required(o::Atp45ResultCollection)
    o.type === nothing && (return false)
    o.features === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ Atp45ResultCollection }, name::Symbol, val)
    if name === Symbol("type")
        OpenAPI.validate_param(name, "Atp45ResultCollection", :enum, val, ["Feature", "FeatureCollection", "Point", "MultiPoint", "LineString", "MultiLineString", "Polygon", "MultiPolygon", "GeometryCollection"])
    end
end
