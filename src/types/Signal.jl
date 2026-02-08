"""
    Signal

Generic signal definition for CAN messages.

# Fields
- `name::String`: Signal name
- `start_byte::UInt8`: Starting byte position (1-indexed)
- `start_bit::UInt8`: Starting bit position within the byte (1-indexed)
- `length::UInt8`: Signal length in bits
- `scaling::Float64`: Scaling factor for conversion
- `offset::Float64`: Offset for conversion

Physical value = raw_value * scaling + offset
"""
struct Signal
    name::String
    start_byte::UInt8
    start_bit::UInt8
    length::UInt8
    scaling::Float64
    offset::Float64

    function Signal(name::AbstractString, start_byte::Integer, start_bit::Integer,
                    length::Integer, scaling::Real, offset::Real)
        return new(String(name), UInt8(start_byte), UInt8(start_bit), UInt8(length),
                   Float64(scaling), Float64(offset))
    end

    function Signal()
        return new("", UInt8(0), UInt8(0), UInt8(0), 1.0, 0.0)
    end
end

function Base.show(io::IO, sig::Signal)
    println(io)
    println(io, "----------------------")
    println(io, "***** ", sig.name, " *****")
    println(io, "    StartByte: ", sig.start_byte)
    println(io, "    StartBit: ", sig.start_bit)
    println(io, "    Length: ", sig.length)
    println(io, "    Offset: ", sig.offset)
    println(io, "    Scaling: ", sig.scaling)
    println(io, "----------------------")
    return nothing
end
