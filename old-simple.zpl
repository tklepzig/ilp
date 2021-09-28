param number_of_slots := 4;
param number_of_rooms := 2;

set Slots := {1..number_of_slots};
set People := { read "zimpl_input/people.txt" as "<1s>" comment "#"};
set Sessions := { read "zimpl_input/sessions.txt" as "<1s>" comment "#"};

param dauer[Sessions] := read "zimpl_input/sessions.txt" as "<1s> 2n" comment "#";
param mandatory[People*Sessions]:= read "zimpl_input/mandatory.txt" as "<1s,2s> 3n" comment "#";
param interested[People*Sessions]:= read "zimpl_input/interested.txt" as "<1s,2s> 3n" comment "#";

var x[Slots*Sessions] binary;
var schwacherKonflikt[People] integer;
var start[Slots*Sessions] binary;

minimize anzahl_der_schwachen_konflikte_minimieren:
	sum <v> in People:
		schwacherKonflikt[v];

subto Anzahl_an_schwachen_Konflikten:
	forall <v> in People:
		forall <i> in Slots:
			sum <s> in Sessions:
				(interested[v,s]+mandatory[v,s])*x[i,s] <= schwacherKonflikt[v] + 1;

subto jede_session_wurde_zugeordnet:
	forall <s> in Sessions:
		sum <i> in Slots:
			x[i,s] == dauer[s];

subto maximale_Anzahl_an_parallelen_Sessions:
	forall <i> in Slots:
		sum <s> in Sessions:
			x[i,s] <= number_of_rooms;

subto keine_starken_Konflikte:
	forall <v> in People:
		forall <i> in Slots:
			sum <s> in Sessions:
				mandatory[v,s]*x[i,s] <= 1;

subto session_beginnt:
	forall <s> in Sessions:
		x[1,s] <= start[1,s];

subto session_startet:
	forall <s> in Sessions:
		forall <i> in {1..(number_of_slots-1)}:
			x[i+1,s] - x[i,s] <= start[i+1,s];

subto maximal_ein_start:
	forall <s> in Sessions:
		sum <i> in Slots: start[i,s] == 1;


