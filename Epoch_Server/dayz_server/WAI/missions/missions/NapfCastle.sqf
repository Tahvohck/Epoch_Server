private ["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

_position = [11077.9,11798.4,0.001];
diag_log format["Napf castle: Napf castle loot and guards are setup "];
_box = createVehicle ["BAF_VehicleBox",[11077.9,11798.4,0.001], [], 0, "CAN_COLLIDE"];
[_box] call spawn_ammo_box;

_rndnum = round (random 3) + 4;
[[11087.9,11808.4,0.001],                  //position
_rndnum,						  //Number Of units
1,					      //Skill level 0-1. Has no effect if using custom skills
"Random",			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"CZ_Special_Forces_GL_DES_EP1_DZ",						  //Skin "" for random or classname here.
"Random",				  //Gearset number. "Random" for random gear set.
true
] call spawn_group;

[[11067.9,11788.4,0.001],                  //position
8,						  //Number Of units
1,					      //Skill level 0-1. Has no effect if using custom skills
"Random",			      //Primary gun set number. "Random" for random weapon set.
4,						  //Number of magazines
"",						  //Backpack "" for random or classname here.
"CZ_Special_Forces_GL_DES_EP1_DZ",						  //Skin "" for random or classname here.
"Random",				  //Gearset number. "Random" for random gear set.
true
] call spawn_group;

[[[_position select 0, (_position select 1) + 10, 0],[(_position select 0) + 10, _position select 1, 0]], //position(s) (can be multiple).
"SPG9_TK_INS_EP1",             //Classname of turret
0.5,					  //Skill level 0-1. Has no effect if using custom skills
"CZ_Special_Forces_GL_DES_EP1_DZ",				          //Skin "" for random or classname here.
0,						  //Primary gun set number. "Random" for random weapon set. (not needed if ai_static_useweapon = False)
2,						  //Number of magazines. (not needed if ai_static_useweapon = False)
"",						  //Backpack "" for random or classname here. (not needed if ai_static_useweapon = False)
"Random",				  //Gearset number. "Random" for random gear set. (not needed if ai_static_useweapon = False)
true
] call spawn_static;


[_position,"Legion Napf Ruins"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";
_hint = parseText format["<t align='center' color='#ff0000' shadow='2' size='1.75'>Major Mission!</t><br/><t  align='center' color='#ffffff'>Legion men have stormed the Napf ruins! We have to clear them out!</t>"];
customRemoteMessage = ['hint', _hint];
publicVariable "customRemoteMessage";

_missiontimeout = true;
_cleanmission = false;
_playerPresent = false;
_starttime = floor(time);
while {_missiontimeout} do {
	sleep 5;
	_currenttime = floor(time);
	{if((isPlayer _x) AND (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
	if (_currenttime - _starttime >= wai_mission_timeout) then {_cleanmission = true;};
	if ((_playerPresent) OR (_cleanmission)) then {_missiontimeout = false;};
};
if (_playerPresent) then {
	waitUntil
	{
		sleep 5;
		_playerPresent = false;
		{if((isPlayer _x) AND (_x distance _position <= 30)) then {_playerPresent = true};}forEach playableUnits;
		(_playerPresent)
	};
	diag_log format["Napf castle: Napf castle was secured"];
	_hint = parseText format["<t align='center' color='#00FF11' shadow='2' size='1.75'>SUCCESS!</t><br/><t  align='center' color='#ffffff'>Survivors have secured the ruins!</t>"];
    customRemoteMessage = ['hint', _hint];
    publicVariable "customRemoteMessage";
} else {
	clean_running_mission = True;
	deleteVehicle _box;
	{_cleanunits = _x getVariable "missionclean";
	if (!isNil "_cleanunits") then {
		switch (_cleanunits) do {
			case "ground" : {ai_ground_units = (ai_ground_units -1);};
			case "air" : {ai_air_units = (ai_air_units -1);};
			case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
			case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
		};
		deleteVehicle _x;
		sleep 0.05;
	};	
	} forEach allUnits;
	
	diag_log format["Napf Ruins: Napf Ruins ended"];
	_hint = parseText format["<t align='center' color='#ff1133' shadow='2' size='1.75'>FAILED</t><br/><t  align='center' color='#ffffff'>Survivors did not secure the ruins!</t>"];
    customRemoteMessage = ['hint', _hint];
    publicVariable "customRemoteMessage";
};
missionrunning = false;