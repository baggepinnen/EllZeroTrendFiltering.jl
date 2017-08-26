using Base.Test

include("../src/dev.jl")

using Polynomials


t = [-1; 0; 1]

g = Poly([0])
ℓ = dev.compute_transition_costs(g, t)
@test ℓ[1,2].P == 1/6*[2 1; 1 2]
@test ℓ[1,2].q == [0,0]
@test ℓ[1,2].r == 0


g = Poly([1])
ℓ = dev.compute_transition_costs(g, t)
@test ℓ[1,2].P == 1/6*[2 1; 1 2]
@test ℓ[1,2].q == [-1,-1]
@test ℓ[1,2].r == 1


g = Poly([0,1])
ℓ = dev.compute_transition_costs(g, t)
@test ℓ[2,3].P == 1/6*[2 1; 1 2]
@test ℓ[2,3].q ≈ [-1/3,-2/3]
@test ℓ[2,3].r ≈ 1/3
@test ℓ[2,3](0,0) == 1/3
@test ℓ[2,3](1,1) == 1/3
@test ℓ[2,3](1,2) ≈ 1
@test ℓ[2,3](1,0) ≈ 1/3