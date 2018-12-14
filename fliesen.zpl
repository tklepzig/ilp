
param n:= 13;

set Zeilen := {1..n};
set Spalten := {1..n};
set Fliessen := {1..(n-1)};

var x[Zeilen*Spalten*Fliessen] binary;

minimize Anzahl_der_Fliessen: sum <i> in Zeilen: sum <j> in Spalten: sum <h> in Fliessen: x[i,j,h];


subto eine_Fliesse_pro_Feld:
	forall <i> in Zeilen:
		forall <j> in Spalten:
			sum <h> in Fliessen:
				sum <a> in {0 to min(i-1,h-1)}:
					sum <b> in {0 to min(j-1,h-1)}:
						x[i-a,j-b,h] == 1;

subto nichts_rechts_ueber_Rand:
	forall <h> in Fliessen:
		forall <i> in Zeilen:
			forall <j> in Spalten with j+h-1>13:
				x[i,j,h]==0;

subto nichts_unten_ueber_Rand:
	forall <h> in Fliessen:
		forall <i> in Zeilen with i+h-1>13:
			forall <j> in Spalten:
				x[i,j,h]==0;