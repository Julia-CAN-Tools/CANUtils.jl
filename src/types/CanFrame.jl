"""
    CanFrame

A standard 8-byte CAN data frame with an identifier and payload.

# Fields
- `canid::UInt32` — CAN identifier. For standard CAN this is 11 bits; for extended CAN
  (e.g. J1939) it is 29 bits. Stored as a `UInt32` in both cases.
- `data::FixedSizeArray{UInt8}` — 8-byte data payload.

# Constructor

    CanFrame(canid::Integer, data::AbstractVector{<:Integer})

Creates a CAN frame. Throws `ArgumentError` if `data` is not exactly 8 bytes.
The `canid` is converted to `UInt32` and `data` is copied into a `FixedSizeArray`.

# Examples

```julia
# Create a frame with CAN ID 0x123 and an 8-byte payload
frame = CanFrame(0x123, UInt8[0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

# Extended CAN ID (29-bit, e.g. J1939)
frame = CanFrame(0x0CF00400, UInt8[0xFF, 0x00, 0xA5, 0x00, 0x00, 0x00, 0x00, 0x00])

# Access fields
frame.canid   # 0x0CF00400
frame.data[1] # 0xFF
```
"""
struct CanFrame
    canid::UInt32
    data::FixedSizeArray{UInt8}
    function CanFrame(canid::Integer, data::AbstractVector{<:Integer})
        length(data) == 8 || throw(ArgumentError("CAN frames require 8 bytes"))
        return new(UInt32(canid), FixedSizeArray(data))
    end
end

function Base.show(io::IO, frame::CanFrame)
    println(io)
    println(io, "-----------------------")
    println(io, @sprintf("Can ID: 0x%08X", frame.canid))
    print(io, "Data: ")
    for byte in frame.data
        print(io, @sprintf("%02X ", byte))
    end
    println(io)
    print(io, "-----------------------")
    return nothing
end