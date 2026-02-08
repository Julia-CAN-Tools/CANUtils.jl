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