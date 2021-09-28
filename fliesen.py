from ortools.linear_solver import pywraplp

solver = pywraplp.Solver.CreateSolver("SCIP")

# parameters
n = 13
zeilen = range(n)
spalten = range(n)
fliessen = range(n - 1)

# variables
x = {}
for z in zeilen:
    for s in spalten:
        for f in fliessen:
            x[(z, s, f)] = solver.BoolVar("x[%i,%i,%i]" % (z, s, f))

# objective
solver.Minimize(sum(x[(z, s, f)] for z in zeilen for s in spalten for f in fliessen))

# constraint


solver.Solve()

for z in zeilen:
    for s in spalten:
        for f in fliessen:
            print(x[(z, s, f)].solution_value())
