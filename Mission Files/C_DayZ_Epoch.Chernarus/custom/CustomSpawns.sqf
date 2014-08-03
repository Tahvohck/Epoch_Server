if (!isDedicated) then {
	sleep 1;
	
	//Player UID's
	if ((getPlayerUID player) in ["0"]) exitWith {
	//## Custom Spawn Location 1 - Format: [X,Y,Z] (Z = Height AtTerrainLevel)
		player setPosATL [185,7243,3200];
	};
};