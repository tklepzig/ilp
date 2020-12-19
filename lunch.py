from ortools.linear_solver import pywraplp

solver = pywraplp.Solver.CreateSolver("SCIP")

# parameters
num_days = 14
no_repeat = 10
days = range(num_days)
food = range(12)
food_names = [
    "Fish",
    "Meat",
    "Salad",
    "3",
    "Meat again",
    "Meat once more",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
]
with_meat = [0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0]
food_with_meat = list(filter(lambda x: with_meat[x] == 1, food))

# variables
x = {}
for d in days:
    for f in food:
        x[(d, f)] = solver.BoolVar("x[%i,%i]" % (d, f))

# constraints
# exactly one food per day
for d in days:
    solver.Add(sum(x[(d, f)] for f in food) == 1)

# not the same food on `no_repeat` consecutive days
for d in range(num_days - (no_repeat - 1)):
    for f in food:
        solver.Add(sum(x[(d + b, f)] for b in range(no_repeat)) <= 1)

# Exactly two times meat a week
for d in range(0, num_days, 7):
    solver.Add(sum(x[(d + b, f)] for b in range(7) for f in food_with_meat) == 2)

status = solver.Solve()
if status == pywraplp.Solver.OPTIMAL:
    for d in days:
        if d % 7 == 0:
            print("Week %i" % (d % 6))
        for f in food:
            if x[(d, f)].solution_value() == 1:
                print("\tDay %i: %s" % (d, food_names[f]))
else:
    print("Infeasible")
