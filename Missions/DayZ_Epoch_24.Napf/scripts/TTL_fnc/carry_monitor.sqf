_tower=_this select 0;
_towed=_tower getVariable["TowedObj", objNull];
while {_towed in vehicles} do {sleep 15};
_tower setVariable ["isTowing", false, true];
_tower setVariable ["TowedName", objNull, true];
_tower setVariable ["TowedObj", objNull, true];