module AltInplaceOpsInterface

import LinearAlgebra
import LinearAlgebra: mul!

add!(a::A, b::B) where {A,B} = error("add!(a::$A, b::$B) is not implemented")
minus!(a::A, b::B) where {A,B} = error("minus!(a::$A, b::$B) is not implemented")
pow!(a::A, b::B) where {A,B} = error("pow!(a::$A, b::$B) is not implemented")
max!(a::A, b::B) where {A,B} = error("max!(a::$A, b::$B) is not implemented")
min!(a::A, b::B) where {A,B} = error("min!(a::$A, b::$B) is not implemented")

Base.fill!(a::Vector{Vector{Float64}}, b::Float64) = foreach(x->fill!(x,b), a)
Base.similar(a::Vector{Vector{Float64}}) = map(x->similar(x),a)
Base.zero(a::Vector{Vector{Float64}}) = map(zero,a)

Base.fill!(a::Vector{Matrix{Float64}}, b::Float64) = foreach(x->fill!(x,b), a)
Base.similar(a::Vector{Matrix{Float64}}) = map(x->similar(x),a)
Base.zero(a::Vector{Matrix{Float64}}) = map(zero,a)

## Vector{Float64}

function add!(a::Vector{Float64}, b::Vector{Float64})
	@inbounds @simd for i in 1:length(a)
		 a[i] += b[i]
	end
	return nothing
end
function add!(a::Vector{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] += b
	end
	return nothing
end
function mul!(a::Vector{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] *= b
	end
	return nothing	
end
function mul!(a::Vector{Float64}, b::Vector{Float64})
	@inbounds @simd for i in 1:length(a)
		 a[i] *= b[i]
	end
	return nothing	
end
function mul!(a::Vector{Float64}, b::Vector{Float64}, c::Float64)
	@inbounds @simd for i = 1:length(a)
		a[i] = b[i]*c
	end
	return nothing
end
function minus!(a::Vector{Float64}, b::Vector{Float64})
	@inbounds @simd for i in 1:length(a)
		 a[i] -= b[i]
	end
	return nothing	
end
function pow!(a::Vector{Float64}, b::Int64)
	@inbounds @simd for i in 1:length(a)
		 a[i] ^= b
	end
	return nothing		
end
function pow!(a::Vector{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] ^= b
	end
	return nothing		
end



## Vector{Vector{Float64}}

add!(a::Vector{Vector{Float64}}, b::Vector{Vector{Float64}}) = begin 
	@inbounds for i = 1:length(a); add!(a[i],b[i]) end 
	return nothing
end
add!(a::Vector{Vector{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a); add!(a[i],b) end
	return nothing
end
mul!(a::Vector{Vector{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a); mul!(a[i],b) end
	return nothing
end
mul!(a::Vector{Vector{Float64}}, b::Vector{Vector{Float64}}) = begin
	@inbounds for i = 1:length(a)
		mul!(a[i],b[i]) end
	return nothing
end
mul!(a::Vector{Vector{Float64}}, b::Vector{Vector{Float64}}, c::Float64) = begin
	@inbounds for i = 1:length(a)
		mul!(a[i], b[i], c)
	end
	return nothing
end
function minus!(a::Vector{Vector{Float64}}, b::Vector{Vector{Float64}})
	@inbounds for i = 1:length(a)
		minus!(a[i],b[i]) end
	return nothing	
end
function pow!(a::Vector{Vector{Float64}}, b::Int64)
	@inbounds for i = 1:length(a)
		pow!(a[i],b) end
	return nothing		
end
pow!(a::Vector{Vector{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a)
		pow!(a[i],b)
	end
	return nothing
end

## Vector{Vector{Float64}}

function AltInplaceOpsInterface.add!(a::Matrix{Float64}, b::Matrix{Float64})
	@inbounds @simd for i in 1:length(a)
		 a[i] += b[i]
	end
	return nothing	
end
function AltInplaceOpsInterface.add!(a::Matrix{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] += b
	end
	return nothing	
end
function LinearAlgebra.mul!(a::Matrix{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] *= b
	end
	return nothing		
end
mul!(a::Matrix{Float64}, b::Matrix{Float64}, c::Float64) = begin
	@inbounds @simd for i = 1:length(a)
		a[i] = b[i]*c
	end
	return nothing
end
mul!(a::Matrix{Float64}, b::Matrix{Float64}, c::Matrix{Float64}) = begin
	@inbounds @simd for i = 1:length(a)
		a[i] = b[i]*c[i]
	end
	return nothing
end
mul!(a::Matrix{Float64}, b::Matrix{Float64}) = begin
	mul!(a,a,b)
	return nothing
end
function minus!(a::Matrix{Float64}, b::Matrix{Float64})
	@inbounds @simd for i in 1:length(a)
		 a[i] -= b[i]
	end
	return nothing	
end
function pow!(a::Matrix{Float64}, b::Int64)
	@inbounds @simd for i in 1:length(a)
		 a[i] ^= b
	end
	return nothing		
end
function pow!(a::Matrix{Float64}, b::Float64)
	@inbounds @simd for i in 1:length(a)
		 a[i] ^= b
	end
	return nothing		
end

## Vector{Matrix{Float64}}

add!(a::Vector{Matrix{Float64}}, b::Vector{Matrix{Float64}}) = begin 
	@inbounds for i = 1:length(a); add!(a[i],b[i]) end 
	return nothing
end
add!(a::Vector{Matrix{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a); add!(a[i],b) end
	return nothing
end
mul!(a::Vector{Matrix{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a); mul!(a[i],b) end
	return nothing
end
mul!(a::Vector{Matrix{Float64}}, b::Vector{Matrix{Float64}}) = begin
	@inbounds for i = 1:length(a)
		mul!(a[i],b[i]) end
	return nothing
end
mul!(a::Vector{Matrix{Float64}}, b::Vector{Matrix{Float64}}, c::Float64) = begin
	@inbounds for i = 1:length(a)
		mul!(a[i], b[i], c)
	end
	return nothing
end
function minus!(a::Vector{Matrix{Float64}}, b::Vector{Matrix{Float64}})
	@inbounds for i = 1:length(a)
		minus!(a[i],b[i]) end
	return nothing	
end
function pow!(a::Vector{Matrix{Float64}}, b::Int64)
	@inbounds for i = 1:length(a)
		pow!(a[i],b) end
	return nothing		
end
pow!(a::Vector{Matrix{Float64}}, b::Float64) = begin
	@inbounds for i = 1:length(a)
		pow!(a[i],b)
	end
	return nothing
end


end # module
