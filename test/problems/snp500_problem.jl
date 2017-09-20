function snp500_problem()


    data = readdlm(joinpath(Pkg.dir("DynamicApproximations"),"examples","data","snp500.txt"))
    g = data[1:300]

    M_bf = 2

    ζ = 0.005:0.005:0.05

    I_sols =
    [[1, 300],
    [1, 128, 300],
    [1, 149, 165, 300],
    [1, 78, 146, 164, 300],
    [1, 145, 191, 244, 251, 300],
    [1, 78, 145, 170, 245, 250, 300],
    [1, 64, 68, 144, 170, 245, 250, 300],
    [1, 64, 68, 145, 163, 203, 241, 252, 300],
    [1, 34, 44, 72, 145, 163, 203, 241, 252, 300],
    [1, 63, 74, 95, 104, 144, 163, 203, 241, 252, 300],
    [1, 34, 44, 78, 94, 105, 144, 163, 203, 241, 252, 300],
    [1, 34, 44, 78, 94, 105, 144, 163, 204, 241, 253, 268, 300],
    [1, 34, 44, 78, 94, 105, 144, 163, 205, 233, 245, 252, 268, 300],
    [1, 34, 44, 78, 94, 105, 144, 163, 203, 241, 252, 266, 268, 270, 300]]

    f_sols =
    [0.303993875391825,
    0.2760951476102491,
    0.2058845486408245,
    0.1791507928410283,
    0.13953735503127973,
    0.11683004720180179,
    0.10346917135575495,
    0.09289707415700832,
    0.08484771880284825,
    0.07610803627903806,
    0.06746465092510334,
    0.06367900239456503,
    0.06051435296103591,
    0.05690190505811188]

    return g, M_bf, ζ, I_sols, f_sols
end
