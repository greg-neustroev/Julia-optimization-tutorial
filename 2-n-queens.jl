using JuMP
using HiGHS
using LinearAlgebra

N = 8
chess_model = Model(HiGHS.Optimizer)

@variable(chess_model, x[1:N, 1:N], Bin)

@objective(chess_model, Max, sum(x[:, :]))

# Number of queens
# number in Greek is αριθμός
@constraint(chess_model, α, sum(x[:, :]) == N)

# Row constraints
# rows in Greek is γραμμές
@constraint(chess_model, γ[r ∈ 1:N], sum(x[r, :]) ≤ 1)

# Column constraints
# columns in Greek is στήλες
@constraint(chess_model, σ[c ∈ 1:N], sum(x[:, c]) ≤ 1)

# Diagonal constraints
# diagonals in Greek is διαγώνιες
diagonals = -(N - 1):(N-1)
@constraint(chess_model, δ[d ∈ diagonals], sum(LinearAlgebra.diag(x, d)) ≤ 1)
reversed_x = reverse(x; dims=1)
@constraint(chess_model, Δ[d ∈ diagonals], sum(LinearAlgebra.diag(reversed_x, d)) ≤ 1)

print(chess_model)

optimize!(chess_model)

if termination_status(chess_model) == OPTIMAL
    solution = round.(Int, value.(x))

    println("A soultion is: ")
    display(solution)
elseif termination_status(chess_model) == INFEASIBLE
    println("There is no feasible solution")
else
    println("Something went wrong")
end
