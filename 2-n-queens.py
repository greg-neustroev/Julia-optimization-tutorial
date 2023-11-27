from pyomo.environ import *
import numpy as np
import time

t = time.time()

N = 8
model = AbstractModel()
model.rows = RangeSet(N)
model.cols = Set(initialize=model.rows)
model.diags = RangeSet(2-N, N-2)

model.x = Var(model.rows, model.cols, within=Binary)


def rule_total(model):
    return sum(model.x[r, c] for r in model.rows for c in model.cols) == N


def rule_rows(model, r):
    return sum(model.x[r, c] for c in model.cols) == 1


def rule_cols(model, c):
    return sum(model.x[r, c] for r in model.rows) == 1


def rule_diag(model, d):
    return sum(model.x[i, i+d] for i in model.rows if 0 < i+d <= N) <= 1


def rule_diag2(model, d):
    return sum(model.x[N-i+1, i+d] for i in model.rows if 0 < i+d <= N) <= 1


def rule_objective(model):
    return sum(model.x[r, c] for r in model.rows for c in model.cols)


model.C0 = Constraint(rule=rule_total)
model.C1 = Constraint(model.rows, rule=rule_rows)
model.C2 = Constraint(model.cols, rule=rule_cols)
model.C3 = Constraint(model.diags, rule=rule_diag)
model.C4 = Constraint(model.diags, rule=rule_diag2)
model.obj = Objective(rule=rule_objective, sense=maximize)
instance = model.create_instance()
slvr = 'appsi_highs'
if SolverFactory(slvr).available():
    print("Solver " + slvr + " is available.")
else:
    print("Solver " + slvr + " is not available.")
optimizer = SolverFactory(slvr)
optimizer.solve(instance)

t = time.time() - t
print(f"Elapsed time: {round(t, 3)} s")

solution = np.array([int(v.value)
                    for v in instance.component_data_objects(Var)])
solution = solution.reshape((N, N))
print(solution)
