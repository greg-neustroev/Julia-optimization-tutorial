using JuMP
using HiGHS
using LinearAlgebra
using Pkg

@time begin
    N = 100
    chess_model = Model(HiGHS.Optimizer)

    @variable(chess_model, x[1:N, 1:N], Bin)

    @objective(chess_model, Max, sum(x[:, :]))

    # Number of queens
    @constraint(chess_model, sum(x[:, :]) == N)

    # Row constraints
    @constraint(chess_model, [r ∈ 1:N], sum(x[r, :]) == 1)

    # Column constraints
    @constraint(chess_model, [c ∈ 1:N], sum(x[:, c]) == 1)

    # Diagonal constraints
    diagonals = (2-N):(N-2)
    # LinearAlgebra.diag(x, d) return the d-th diagonal of a matrix x
    # where 0-th diagonal is the main diagonal, positive d are the upper
    # subdiagonals, and negative d are the lower subdiagonals
    @constraint(chess_model, [d ∈ diagonals], sum(LinearAlgebra.diag(x, d)) ≤ 1)
    reversed_x = reverse(x; dims=2)
    @constraint(chess_model, [d ∈ diagonals], sum(LinearAlgebra.diag(reversed_x, d)) ≤ 1)

    # print(chess_model)
    optimize!(chess_model)
end

if termination_status(chess_model) == OPTIMAL
    solution = round.(Int, value.(x))

    println("A soultion is: ")
    display(solution)
elseif termination_status(chess_model) == INFEASIBLE
    println("There is no feasible solution")
else
    println("Something went wrong")
end
