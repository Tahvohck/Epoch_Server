#define COMP compile preprocessFileLineNumbers
//Override for crows, persistent death records.
server_playerDied 	= COMP "\z\addons\dayz_server\compile overrides\override_playerDied.sqf";
//Override for custom spawns.
server_playerSetup  = COMP "\z\addons\dayz_server\compile overrides\override_playerSetup.sqf";

TAHV_CrowsAfterWait	= {
	_Pos	= _this select 0;
	_num	= _this select 1;
	_wait	= _this select 2;
	_radius	= _this select 3;
	_height	= _this select 4;
	sleep _wait;
	[_Pos, _radius, _num, _height] call bis_fnc_crows;
};
