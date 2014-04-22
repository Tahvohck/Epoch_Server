//Usage: [Action, Attaching vehicle,  Towing vehicle]
//Fucking scope. Preinit.
_action	= objNull;
_aVeh	= objNull;
_tVeh	= objNull;
_ID		= -1;

//Allow for using this script without addAction.
if (typeName (_this select 0) == "STRING") then {
		_action = _this select 0;
		_aVeh	= _this select 1;
		_tVeh	= _this select 2;
	} else {
		_ID		= _this select 2;
		
		_action = _this select 3 select 0;
		_aVeh	= _this select 3 select 1;
		_tVeh	= _this select 3 select 2;
};

switch (toLower _action) do {
	case "tow": {
		_aName	= getText (configFile >> "CfgVehicles" >> (typeOf _aVeh) >> "displayName");
		_tName	= getText (configFile >> "CfgVehicles" >> (typeOf _tVeh) >> "displayName");
		if (_aVeh distance _tVeh <= ttl_towRadius) then {
			_tTowClass = [_tVeh, ttl_canTow] call ttl_gCorClass;
			if (!(_tVeh getVariable ["isTowing", false])) then {
				_aVehW	= [_aVeh, ttl_weightClass] call ttl_gCorClass;
				if (_tTowClass >= _aVehW) then {
					//True bounding centers. boundingCenter returns an [x,z,y] Array.
					_t = boundingCenter _aVeh;
					_aTBC = [_t select 0, _t select 2, _t select 1];
					_t = boundingCenter _tVeh;
					_tTBC = [_t select 0, _t select 2, _t select 1];
					_t = boundingCenter player;
					_pTBC = [_t select 0, _t select 2, _t select 1];
					_t = nil;

					titleText [format["Towing %1 to %2...", _aName, _tName], "PLAIN DOWN"];
					//Player animation and positioning. Originally stolen shamelessly from R3F, now mostly
					//my own algo.
					player attachTo [_tVeh, [
						(boundingBox _tVeh select 1 select 0) + 1,
						(boundingBox _tVeh select 0 select 1) + .25,
						(_tVeh worldToModel (player modelToWorld _pTBC)) select 2
					]];
					player setDir 270 + 30; //First at 90° to car, inwards, then rotated towards the hitch.
					player playMove "AinvPknlMstpSlayWrflDnon_medic";
					sleep .5;

					//Create the offsets, attach.
					_x = (boundingCenter _aVeh select 0) - (boundingCenter _tVeh select 0);
					_y = (boundingBox _tVeh select 0 select 1) -
							(boundingBox _aVeh select 1 select 1) +
							(_tTBC select 1) - 1;
					_z = (_tVeh worldToModel (_aVeh modelToWorld _aTBC) select 2) - (_aTBC select 2);
					_aVeh attachTo [_tVeh, [_x,_y,_z]];
					
					//Set the relevant vehicle variables.
					_tVeh setVariable ["isTowing", true, true];
					_tVeh setVariable ["TowedObj", _aVeh, true];
					_tVeh setVariable ["TowedName", _aName, true];
					_aVeh setVariable ["TowedBy", _tVeh, true];
					_aVeh setVariable ["beingTowed", true, true];
					
					detach player;
					["cancel"] execVM ""+ttl_loc+"TargetCtrl.sqf";
					if (-1 != _ID) then {player removeAction _ID};
				} else {titleText [format["%1 is not powerful enough to tow a %2", _tName, _aName], "PLAIN DOWN"]};
			} else {titleText [format["%1 cannot tow %2, already towing a %3",
								_tName, _aName, _tVeh getVariable ["TowedName", "<That ain't right>"]], "PLAIN DOWN"]};
		} else {titleText [format["%1 is too far away from %2", _aName, _tName], "PLAIN DOWN"]};
	};
	case "untow": {
		_t		= velocity _aVeh;
		_vel 	= [_t select 0, _t select 2, _t select 1];
		detach _aVeh;
		_aVeh setVelocity _vel;
		_tVeh = _aVeh getVariable ["TowedBy", objNull];
		_tVeh setVariable ["isTowing", false, true];
		_tVeh setVariable ["TowedName", objNull, true];
		_tVeh setVariable ["TowedObj", objNull, true];
		_aVeh setVariable ["TowedBy", objNull, true];
		_aVeh setVariable ["beingTowed", false, true];
		
		_aVeh setVelocity [0,0.1,0];
		if (-1 != _ID) then {player removeAction _ID};
	};
	default {diag_log format["%1", _action];};
};
