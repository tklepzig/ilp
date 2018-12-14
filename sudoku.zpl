
set Zeilen := {1..9};
set Spalten := {1..9};
set Nummer := {1..9};

set BlockZeilen := {1..3};
set BlockSpalten := {1..3};

var f[Zeilen*Spalten*Nummer] binary;

subto eine_Nummer_pro_Spalte:
	forall <y> in Zeilen:
		forall <n> in Nummer:
			sum <x> in Spalten:
				f[y, x, n] == 1;

subto eine_Nummer_pro_Zeile:
	forall <x> in Spalten:
		forall <n> in Nummer:
			sum <y> in Zeilen:
				f[y, x, n] == 1;

subto pro_Feld_eine_Nummer:
	forall <x> in Spalten:
		forall <y> in Zeilen:
			sum <n> in Nummer:
				f[y, x, n] == 1;

subto pro_3mal3_eine_Nummer:
	forall <n> in Nummer:
		forall <k> in {0..2}:
			forall <l> in {0..2}:
				sum <x> in BlockSpalten:
					sum <y> in BlockZeilen:
						f[y+k*3, x+l*3, n] == 1;

