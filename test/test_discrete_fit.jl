using Base.Test

include(joinpath(Pkg.dir("DynamicApproximations"),"src","dev.jl"))

include(joinpath(Pkg.dir("DynamicApproximations"),"test","problems", "snp500_problem.jl"))
include(joinpath(Pkg.dir("DynamicApproximations"),"test","problems", "exp_problem.jl"))
include(joinpath(Pkg.dir("DynamicApproximations"),"test","problems", "square_wave_problem.jl"))
include(joinpath(Pkg.dir("DynamicApproximations"),"test","problems", "straight_line_problem.jl"))

##

@testset "Data set: $problem_fcn" for problem_fcn in [straight_line_problem, square_wave_problem, exp_problem, snp500_problem]

##
problem_fcn = straight_line_problem
g, M_bf, ζvec, I_sols, f_sols = problem_fcn()

g = 0:0.1:1

M = length(I_sols)

#g = exp.(linspace(0,5,11))

@time ℓ = dev.compute_discrete_transition_costs(g);
cost_last = dev.QuadraticPolynomial(1.0, -2*g[end], g[end]^2)

Λ = dev.find_optimal_fit(ℓ, cost_last, M, Inf);

@testset "Data set: $problem_fcn, constrained with m=$m" for m in 1:M
    I, Y, f = dev.recover_solution(Λ[m, 1], ℓ, cost_last)

    @test isempty(I_sols[m]) || I == I_sols[m]
    @test f ≈ f_sols[m]   rtol=1e-10 atol=1e-10
end


##

@testset "Data set: $problem_fcn, bruteforce with m=$m" for m in 1:M_bf

    I_bf, Y_bf, f_bf = dev.brute_force_optimization(ℓ, cost_last, m)

    @test isempty(I_sols[m]) || I_bf == I_sols[m]
    @test f_bf ≈ f_sols[m]  rtol=1e-10 atol=1e-10

    if !isempty(I_sols[m])
        Y_recovered, f_recovered = dev.find_optimal_y_values(ℓ, cost_last, I_sols[m])
        @test Y_bf ≈ Y_recovered    rtol=1e-10
    end
end

##

#ζvec = [100, 30, 10, 3, 1, 0.3, 0.1, 0.03, 0.01]
@testset "Data set: $problem_fcn, regularization with ζ=$ζ" for ζ in ζvec

    Λ_reg = dev.regularize(ℓ, cost_last, ζ)

    # the cost f returned from recover_optimal_index_set includes the
    # regularization penality mζ
    I, _, f_reg = dev.recover_optimal_index_set(Λ_reg[1])

    # Use the costs above to find out how many segments the solution should contain
    m_expected = indmin([f_sols[m] + m*ζ for m=1:length(f_sols)])

    @test m_expected == length(I) - 1
    @test isempty(I_sols[m]) || I == I_sols[m_expected]
    @test f_reg ≈ f_sols[m_expected] + ζ*m_expected

    #println(problem_fcn, "  " , length(I))
end

##
end