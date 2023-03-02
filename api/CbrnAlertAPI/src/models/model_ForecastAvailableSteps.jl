# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""
    ForecastAvailableSteps(;
        start=nothing,
        leadtimes=nothing,
    )

    - start::ZonedDateTime
    - leadtimes::Vector{ZonedDateTime}
"""
Base.@kwdef mutable struct ForecastAvailableSteps <: OpenAPI.APIModel
    start::Union{Nothing, ZonedDateTime} = nothing
    leadtimes::Union{Nothing, Vector{ZonedDateTime}} = nothing

    function ForecastAvailableSteps(start, leadtimes, )
        OpenAPI.validate_property(ForecastAvailableSteps, Symbol("start"), start)
        OpenAPI.validate_property(ForecastAvailableSteps, Symbol("leadtimes"), leadtimes)
        return new(start, leadtimes, )
    end
end # type ForecastAvailableSteps

const _property_types_ForecastAvailableSteps = Dict{Symbol,String}(Symbol("start")=>"ZonedDateTime", Symbol("leadtimes")=>"Vector{ZonedDateTime}", )
OpenAPI.property_type(::Type{ ForecastAvailableSteps }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ForecastAvailableSteps[name]))}

function check_required(o::ForecastAvailableSteps)
    o.start === nothing && (return false)
    o.leadtimes === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ForecastAvailableSteps }, name::Symbol, val)
    if name === Symbol("start")
        OpenAPI.validate_param(name, "ForecastAvailableSteps", :format, val, "date-time")
    end
end
