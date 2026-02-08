# Generic bit addition utilities for CAN data encoding

"""
    add_bits(data_g::UInt64, sigbits::UInt64, startbit_g::Integer, length::Integer) -> UInt64

Add `length` bits at position `startbit_g` in the 64-bit data word.

# Arguments
- `data_g::UInt64`: The existing 64-bit data word
- `sigbits::UInt64`: The bits to add
- `startbit_g::Integer`: Starting bit position (0-indexed from LSB)
- `length::Integer`: Number of bits

# Returns
The updated data word with the new bits inserted.
"""
function add_bits(data_g::UInt64, sigbits::UInt64, startbit_g::Integer, length::Integer)
    maskbits = length >= 64 ? typemax(UInt64) : (UInt64(1) << length) - UInt64(1)
    mask = maskbits << startbit_g
    data_g &= ~mask
    data_g |= sigbits << startbit_g
    return data_g
end

"""
    add_signal(data_g::UInt64, sigbits::UInt64, sig::Signal) -> UInt64

Add signal bits to a 64-bit data word using the signal definition.

# Arguments
- `data_g::UInt64`: The existing 64-bit data word
- `sigbits::UInt64`: The raw signal bits to add
- `sig::Signal`: Signal definition with start_byte, start_bit, and length

# Returns
The updated data word with the signal inserted.
"""
function add_signal(data_g::UInt64, sigbits::UInt64, sig::Signal)
    startbit_g = UInt64(sig.start_byte - 1) * UInt64(8) + UInt64(sig.start_bit - 1)
    return add_bits(data_g, sigbits, startbit_g, sig.length)
end

"""
    uint_to_payload(data_g::UInt64) -> FixedSizeArray{UInt8}

Convert a 64-bit integer to an 8-byte CAN payload (little-endian).

# Arguments
- `data_g::UInt64`: The 64-bit data word

# Returns
An 8-byte FixedSizeArray.
"""
function uint_to_payload(data_g::UInt64)
    data = FixedSizeArray{UInt8}(undef, 8)
    for i = 1:8
        data[i] = UInt8((data_g >> (8 * (i - 1))) & UInt64(0xff))
    end
    return data
end

"""
    store_sigdict!(sigdict::Dict{String,Float64}, storage::Dict{String,Vector{Float64}}) -> Dict{String,Vector{Float64}}

Store current signal values to a history storage.

# Arguments
- `sigdict::Dict{String,Float64}`: Current signal values
- `storage::Dict{String,Vector{Float64}}`: History storage

# Returns
The updated storage.
"""
function store_sigdict!(sigdict::Dict{String,Float64}, storage::Dict{String,Vector{Float64}})
    for (key, value) in sigdict
        if !haskey(storage, key)
            storage[key] = Float64[]
        end
        push!(storage[key], value)
    end
    return storage
end
