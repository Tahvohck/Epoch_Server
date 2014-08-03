_tower=_this select 0;
_towed=_tower getVariable["TowedObj", objNull];
while {_towed in vehicles && (_towed distance _tower) < 15} do {sleep 15};
_tower setVariable ["isTowing", false, true];
_tower setVariable ["TowedName", objNull, true];
_tower setVariable ["TowedObj", objNull, true];