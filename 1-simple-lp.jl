using JuMP
using HiGHS
using Printf

model = Model(HiGHS.Optimizer)

@variable(model, x ≥ 0)
@variable(model, 0 ≤ y ≤ 5)

@objective(model, Max, x + 2y)  # Note how you don't need a * between 2 and y

@constraint(model, λ, 3x + y ≤ 101)

print(model)

optimize!(model)

@printf("The optimal objective is %.0f\n", objective_value(model))

@printf("The primal values are x = %.1f and y = %.1f\n", value(x), value(y))

@printf("The dual value is λ = %.3f\n", dual(λ))
