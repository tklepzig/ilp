set Items := {1..3};

param Gewicht := 10;
param Weights[Items] := <1>6, <2>5, <3>5;
param Values[Items] := <1>11, <2>6, <3>6;

var x[Items] binary;

maximize Value_of_Items:
  sum <i> in Items:
    x[i]*Values[i];

subto Gesamtgewicht_nicht_ueberschritten:
  sum <i> in Items:
    x[i]*Weights[i] <= Gewicht;
