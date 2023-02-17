# AltInplaceOpsInterface.jl
This is a package for interfacing some inplace operations due to old julia code

## Inplace interface functions

```julia
module AltInplaceOpsInterface

add!(a::A, b::B) where {A,B} = error("add!(a::$A, b::$B) is not implemented")
minus!(a::A, b::B) where {A,B} = error("minus!(a::$A, b::$B) is not implemented")
pow!(a::A, b::B) where {A,B} = error("pow!(a::$A, b::$B) is not implemented")
max!(a::A, b::B) where {A,B} = error("max!(a::$A, b::$B) is not implemented")
min!(a::A, b::B) where {A,B} = error("min!(a::$A, b::$B) is not implemented")

end # module
```
