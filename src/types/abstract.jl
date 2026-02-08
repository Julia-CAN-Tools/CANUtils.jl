"""
Abstract interface for CAN message parsers.

Protocol-specific parsers must:
1. Create a concrete message type that subtypes `AbstractCanMessage`
2. Implement the interface functions for their message type

Julia's multiple dispatch will automatically route calls to the correct implementation.
"""

"""
    AbstractCanMessage

Abstract base type for CAN message definitions.

All protocol-specific message types should subtype this.
"""
abstract type AbstractCanMessage end

"""
    decode!(frame::CanFrame, message::AbstractCanMessage, sigdict::Dict{String,Float64}) -> Dict{String,Float64}

Decode a CAN frame using the message definition, storing results in `sigdict`.

# Arguments
- `frame::CanFrame`: The CAN frame to decode
- `message::AbstractCanMessage`: Message definition with signal specifications
- `sigdict::Dict{String,Float64}`: Dictionary to store decoded signal values

# Returns
The updated `sigdict` with decoded values.
"""
function decode!(frame::CanFrame, message::AbstractCanMessage, sigdict::Dict{String,Float64})
    error("decode! not implemented for message type: $(typeof(message))")
end

"""
    match_and_decode!(frame::CanFrame, messages::Vector{<:AbstractCanMessage}, sigdict::Dict{String,Float64}) -> Bool

Find a matching message definition for the frame and decode it.

# Arguments
- `frame::CanFrame`: The CAN frame to match and decode
- `messages::Vector{<:AbstractCanMessage}`: List of message definitions to match against
- `sigdict::Dict{String,Float64}`: Dictionary to store decoded signal values

# Returns
`true` if a matching message was found and decoded, `false` otherwise.
"""
function match_and_decode!(frame::CanFrame, messages::Vector{<:AbstractCanMessage}, sigdict::Dict{String,Float64})
    error("match_and_decode! not implemented for message type: $(eltype(messages))")
end

"""
    encode(message::AbstractCanMessage, sigdict::AbstractDict{String,<:Real}) -> CanFrame

Encode signal values into a CAN frame using the message definition.

# Arguments
- `message::AbstractCanMessage`: Message definition with signal specifications
- `sigdict::AbstractDict{String,<:Real}`: Dictionary of signal values to encode

# Returns
A `CanFrame` with the encoded data.
"""
function encode(message::AbstractCanMessage, sigdict::AbstractDict{String,<:Real})
    error("encode not implemented for message type: $(typeof(message))")
end

"""
    create_signal_dict(messages::Vector{<:AbstractCanMessage}, extra_names::Vector{String}=String[]) -> Dict{String,Float64}

Create a signal dictionary with all signal names from the messages initialized to 0.0.

# Arguments
- `messages::Vector{<:AbstractCanMessage}`: List of message definitions
- `extra_names::Vector{String}`: Additional signal names to include

# Returns
A `Dict{String,Float64}` with all signal names as keys, initialized to 0.0.
"""
function create_signal_dict(messages::Vector{<:AbstractCanMessage}, extra_names::Vector{String}=String[])
    error("create_signal_dict not implemented for message type: $(eltype(messages))")
end
