# Generic bit extraction utilities for CAN data

"""
    extract_bits(data_g::UInt64, startbit_g::Integer, length::Integer) -> UInt64

Extract `length` bits starting at `startbit_g` from a 64-bit data word.

# Arguments
- `data_g::UInt64`: The 64-bit data word (8 bytes packed as little-endian)
- `startbit_g::Integer`: Starting bit position (0-indexed from LSB)
- `length::Integer`: Number of bits to extract

# Returns
The extracted bits as a UInt64.
"""
function extract_bits(data_g::UInt64, startbit_g::Integer, length::Integer)
    length < 1 && return UInt64(0)
    mask = length >= 64 ? typemax(UInt64) : (UInt64(1) << length) - UInt64(1)
    mask <<= startbit_g
    return (data_g & mask) >> startbit_g
end

"""
    extract_signal(data_g::UInt64, sig::Signal) -> UInt64

Extract raw signal bits from a 64-bit data word using the signal definition.

# Arguments
- `data_g::UInt64`: The 64-bit data word
- `sig::Signal`: Signal definition with start_byte, start_bit, and length

# Returns
The raw signal bits as a UInt64 (before scaling/offset).
"""
function extract_signal(data_g::UInt64, sig::Signal)
    startbit_g = UInt64(sig.start_byte - 1) * UInt64(8) + UInt64(sig.start_bit - 1)
    return extract_bits(data_g, startbit_g, sig.length)
end

@inline function _accumulate_bytes(iter)
    value = UInt64(0)
    i = 0
    for byte in iter
        value += UInt64(byte) << (8 * i)
        i += 1
    end
    return value
end

"""
    data_to_int(data::AbstractVector{<:Integer}) -> UInt64

Convert an 8-byte CAN payload to a 64-bit integer (little-endian).

# Arguments
- `data::AbstractVector{<:Integer}`: 8-byte payload

# Returns
The payload as a UInt64.
"""
function data_to_int(data::AbstractVector{<:Integer})
    length(data) == 8 || throw(ArgumentError("CAN frames require 8 bytes"))
    return _accumulate_bytes(data)
end

function data_to_int(data::NTuple{8,<:Integer})
    return _accumulate_bytes(data)
end
