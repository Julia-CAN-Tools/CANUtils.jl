struct CanId
    priority::UInt8
    edp::UInt8
    dp::UInt8
    pf::UInt8
    ps::UInt8
    sa::UInt8
end

function CanId(priority::Integer, pf::Integer, ps::Integer, sa::Integer)
    priority_u = UInt8(priority)
    edp_u = UInt8(0)
    dp_u = UInt8(0)
    pf_u = UInt8(pf)
    ps_u = UInt8(ps)
    sa_u = UInt8(sa)

    return CanId(priority_u, edp_u, dp_u, pf_u, ps_u, sa_u)
end

function CanId(rawid::Integer)
    priority = UInt8((rawid & PRIORITY_MASK) >> 26)
    edp = UInt8((rawid & EDP_MASK) >> 25)
    dp = UInt8((rawid & DP_MASK) >> 24)
    pf = UInt8((rawid & PF_MASK) >> 16)
    ps = UInt8((rawid & PS_MASK) >> 8)
    sa = UInt8(rawid & SA_MASK)

    return CanId(priority, edp, dp, pf, ps, sa)
end

function encode_can_id(canid::CanId)
    return (UInt32(canid.priority) << 26) |
            (UInt32(canid.edp) << 25) |
            (UInt32(canid.dp) << 24) |
            (UInt32(canid.pf) << 16) |
            (UInt32(canid.ps) << 8) |
            UInt32(canid.sa)
end

function decode_can_id(rawid::Integer)
    CanId(rawid)
end

function Base.show(io::IO, canid::CanId)
    println(io)
    println(io, "---------------------")
    println(io, "   Priority: ", canid.priority)
    println(io, "   DP: ", canid.dp)
    println(io, "   EDP: ", canid.edp)
    println(io, "   PF: ", canid.pf)
    println(io, "   PS: ", canid.ps)
    println(io, "   SA: ", canid.sa)
    println(io, "---------------------")

    return nothing
end