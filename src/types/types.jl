const PRIORITY_MASK = UInt32(0x1c000000)
const EDP_MASK = UInt32(0x02000000)
const DP_MASK = UInt32(0x01000000)
const PF_MASK = UInt32(0x00ff0000)
const PS_MASK = UInt32(0x0000ff00)
const SA_MASK = UInt32(0x000000ff)
const PGN_MASK = UInt32(0x00ffff00)

include("CanFrame.jl")