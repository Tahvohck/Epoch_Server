//BIG MISSION OLKE EDIT FOR WAI VER 1.0
//Bulidings spanw+hamwe+M2StaticMG+Bandits+armweapon for loot
 
private ["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];
vehclass = military_unarmed call BIS_fnc_selectRandom;
 
_position = [getMarkerPos "center",0,5500,10,0,2000,0] call BIS_fnc_findSafePos;
 
 _box = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
[_box] call Best_box;
 
diag_log format["WAI: Mission Bandit Base Started At %1",_position];
 
_baserunover = createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, _position select 1, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, _position select 1, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["land_fortified_nest_big",[_position select 0, (_position select 1) - 40, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["land_fortified_nest_big",[_position select 0, (_position select 1) + 40, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) - 10, _position select 1, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) + 10, _position select 1, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Land_Fort_Watchtower",[_position select 0, (_position select 1) - 10, -0.2],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["Land_Fort_Watchtower",[_position select 0, (_position select 1) + 10, -0.2],[], 0, "CAN_COLLIDE"];

_rndnum = round (random 3) + 1;
[[_position select 0, _position select 1, 0],_rndnum,1,"Random",4,"","CZ_Special_Forces_GL_DES_EP1_DZ","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],4,1,"Random",4,"","CZ_Special_Forces_GL_DES_EP1_DZ","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],4,1,"Random",4,"","CZ_Special_Forces_GL_DES_EP1_DZ","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],4,1,"Random",4,"","CZ_Special_Forces_GL_DES_EP1_DZ","Random",true] call spawn_group;
 
[[(_position select 0)+ 40, _position select 1, 0],[(_position select 0)+ 40, _position select 1, 0],50,2,"HMMWV_Armored",1] spawn vehicle_patrol;
 
[[[(_position select 0) - 10, (_position select 1) + 10, 0]],"M2StaticMG",0.8,"CZ_Special_Forces_GL_DES_EP1_DZ",1,2,"","Random",true] call spawn_static;
[[[(_position select 0) + 10, (_position select 1) - 10, 0]],"M2StaticMG",0.8,"CZ_Special_Forces_GL_DES_EP1_DZ",1,2,"","Random",true] call spawn_static;
[[[(_position select 0) + 10, (_position select 1) + 10, 0]],"M2StaticMG",0.8,"CZ_Special_Forces_GL_DES_EP1_DZ",1,2,"","Random",true] call spawn_static;
[[[(_position select 0) - 10, (_position select 1) - 10, 0]],"M2StaticMG",0.8,"CZ_Special_Forces_GL_DES_EP1_DZ",1,2,"","Random",true] call spawn_static;
 
 
[_position,"Legion Firebase"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";
_hint = parseText format["<t align='center' color='#ff0000' shadow='2' size='1.75'>Minor Mission!</t><br/><t  align='center' color='#ffffff'>A Legion force has set up a firebase! Ambush it to make it yours!</t>"];
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
diag_log format["WAI: Mission BaseBandit Ended At %1",_position];
_hint = parseText format["<t align='center' color='#00FF11' shadow='2' size='1.75'>SUCCESS!</t><br/><t  align='center' color='#ffffff'>Survivors captured the base, HOORAH!</t>"];
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
 
diag_log format["WAI: Mission Base Bandit At %1",_position];
_hint = parseText format["<t align='center' color='#ff1133' shadow='2' size='1.75'>FAILED</t><br/><t  align='center' color='#ffffff'>The survivors were unable to capture the base, time is up!</t>"];
    customRemoteMessage = ['hint', _hint];
    publicVariable "customRemoteMessage";
};
 
missionrunning = false;