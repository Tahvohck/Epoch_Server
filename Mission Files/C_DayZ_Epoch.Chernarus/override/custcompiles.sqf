//#include "\z\addons\dayz_code\init\compiles.sqf"
#define COMP compile preprocessFileLineNumbers

fnc_usec_selfActions =	COMP "override\fn_selfActions.sqf";
dayz_spaceInterrupt =	COMP "override\spaceInterrupt.sqf";

if (!isDedicated) then {
	player_build	= COMP "custom\snap_pro\player_build.sqf";
	snap_build		= COMP "custom\snap_pro\snap_build.sqf";
};