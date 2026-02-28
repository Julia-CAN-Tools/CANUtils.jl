module CANUtils
"""
CANUtils - Generic CAN utilities and abstract interface for CAN parsers.

This package provides:
  - Generic CAN types: `CanFrame`, `Signal`
  - Abstract interface: `AbstractCanMessage` with `decode!`, `match_and_decode!`, `encode`, `create_signal_dict`
  - Bit manipulation utilities for CAN data

Protocol-specific parsers should:
1. Subtype `AbstractCanMessage` for their message type
2. Implement the interface functions for their types
"""

using Printf
using FixedSizeArrays

# Include type definitions
include("types/Signal.jl")
include("types/CanFrame.jl")
include("types/abstract.jl")

# Include utilities
include("decoding.jl")
include("encoding.jl")

# Export types
export CanFrame, Signal, AbstractCanMessage

# Export interface functions (to be implemented by parsers)
export decode!, match_and_decode!, encode, create_signal_dict

# Export utility functions
export extract_bits, extract_signal, data_to_int
export add_bits, add_signal, uint_to_payload
export store_sigdict!

end # module CANUtils
