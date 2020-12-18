from ortools.linear_solver import pywraplp

solver = pywraplp.Solver.CreateSolver("SCIP")

# parameters
weight = 10
names = ["Kochplatte", "Zeitschrift", "Brille"]
weights = [6, 5, 5]
values = [11, 6, 6]
items = list(range(len(names)))

# variables
x = {}
for i in items:
    x[i] = solver.BoolVar("x[%i]" % i)

# objective
solver.Maximize(sum(x[i] * values[i] for i in items))

# constraints
solver.Add(sum(x[i] * weights[i] for i in items) <= weight)

status = solver.Solve()
if status == pywraplp.Solver.OPTIMAL:
    print("Objective value =", solver.Objective().Value())
    print("Problem solved in %f milliseconds" % solver.wall_time())
    print("Problem solved in %d iterations" % solver.iterations())
    print("Problem solved in %d branch-and-bound nodes" % solver.nodes())
    print()
    print("Pack folgendes ein:")
    print(
        "Gewicht: %i/%i"
        % (sum(x[i].solution_value() * weights[i] for i in items), weight)
    )
    print("Wert: %i" % sum(x[i].solution_value() * values[i] for i in items))
    for i in items:
        if x[i].solution_value() == 1:
            print(names[i])
else:
    print("Error: Problem is infeasible.")
