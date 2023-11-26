using JuMP
using HiGHS

model = Model(HiGHS.Optimizer)

@variable(model, x ≥ 0)
@variable(model, 0 ≤ y ≤ 5)

@objective(model, Max, x + 2y)  # Note how you don't need a * between 2 and y

@constraint(model, λ, 3x + y ≤ 101)

println(model)

optimize!(model)

println("The optimal objective is:")
println(objective_value(model))

println("The solution is:")
solution = value.((x, y))
println(solution)

println("The dual value is:")
println(dual(λ))
