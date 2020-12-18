from __future__ import print_function
from ortools.linear_solver import pywraplp

solver = pywraplp.Solver.CreateSolver("SCIP")

# parameters
weight = 8
names = ["Kochplatte", "Zeitschrift", "Brille"]
weights = [8, 1, 1]
values = [7, 9, 12]
items = list(range(len(names)))

# variables
x = {}
for i in items:
    x[i] = solver.BoolVar("x[%i]" % i)

# objective
objective = solver.Objective()
for i in items:
    objective.SetCoefficient(x[i], values[i])
objective.SetMaximization()

# constraints
solver.Add(sum(x[i] * weights[i] for i in items) <= weight)

solver.Solve()
print("Pack folgendes ein:")
print(
    "Gewicht: %i/%i" % (sum(x[i].solution_value() * weights[i] for i in items), weight)
)
print("Wert: %i" % sum(x[i].solution_value() * values[i] for i in items))
for i in items:
    if x[i].solution_value() == 1:
        print(names[i])
