int: n;
int: b;
set of int: items=1..n;

array[items] of int: values;
array[items] of int: weights;

solve maximize sum(i in items) (x[i]*values[i]);
constraint sum(i in items) (x[i]*weights[i]) <= b;
/*constraint forall(i in items) (x[i]*weights[i] <= b/2);*/
array[items] of var 0..1: x;

output ["knapsack = \(x)\n"];
output ["\(sum(i in items) (x[i]*values[i]))"]
