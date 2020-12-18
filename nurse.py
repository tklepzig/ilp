from __future__ import print_function
from ortools.linear_solver import pywraplp


model = pywraplp.Solver("nurse-shifts", pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)

# parameters
num_nurses = 5
num_shifts = 3
num_days = 7
min_shifts_per_nurse = (num_shifts * num_days) // num_nurses
max_shifts_per_nurse = min_shifts_per_nurse + 1
all_nurses = range(num_nurses)
all_shifts = range(num_shifts)
all_days = range(num_days)

# variables
shifts = {}
for n in all_nurses:
    for d in all_days:
        for s in all_shifts:
            shifts[(n, d, s)] = model.BoolVar("shift_n%id%is%i" % (n, d, s))


# constraints
for d in all_days:
    for s in all_shifts:
        model.Add(sum(shifts[(n, d, s)] for n in all_nurses) == 1)

for n in all_nurses:
    for d in all_days:
        model.Add(sum(shifts[(n, d, s)] for s in all_shifts) <= 1)

for n in all_nurses:
    num_shifts_worked = sum(shifts[(n, d, s)] for d in all_days for s in all_shifts)
    model.Add(min_shifts_per_nurse <= num_shifts_worked)
    model.Add(num_shifts_worked <= max_shifts_per_nurse)


model.Solve()

print("Solution:")
for d in all_days:
    print("Day", d)
    for n in all_nurses:
        for s in all_shifts:
            if shifts[(n, d, s)].solution_value() == 1:
                print("Nurse", n, "works shift", s)
