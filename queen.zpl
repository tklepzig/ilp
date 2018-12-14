param n:= 8;

set Zeilen := {1..n};
set Spalten := {1..n};

var x[Zeilen*Spalten] binary;

maximize Anzahl_der_Damen: 
	sum <i> in Zeilen: 
		sum <j> in Spalten: 
			x[i,j];

subto eine_Dame_pro_Zeile:
	forall <i> in Zeilen:
		sum <j> in Spalten:
            x[i,j] <= 1;

subto eine_Dame_pro_Spalte:
	forall <j> in Spalten:
		sum <i> in Zeilen:
            x[i,j] <= 1;

subto eine_Dame_pro_Diagonale_Links_Oben_Rechts_Unten:
    forall <k> in {-7..7}:
	    sum <i,j> in Zeilen*Spalten with i+k==j:
			x[i,j] <= 1;

subto eine_Dame_pro_Diagonale_Links_Unten_Rechts_Oben:
    forall <k> in {0..15}:
	    sum <i,j> in Zeilen*Spalten with i+j==k:
			x[i,j] <= 1;
