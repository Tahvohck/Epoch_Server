//Usage: [Attaching vehicle,  Towing vehicle]
//Fucking scope. Preinit.
_action	= objNull;
_aVeh	= objNull;
_tVeh	= objNull;
_ID		= -1;

//Allow for using this script without addAction.
if (typeName (_this select 0) == "STRING") then {
		_aVeh	= _this select 0;
		_tVeh	= _this select 1;
	} else {
		_ID		= _this select 2;
		
		_aVeh	= _this select 3 select 0;
		_tVeh	= _this select 3 select 1;
};

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
			//Player animation and positioning.
			player attachTo [_tVeh, [
				(boundingBox _tVeh select 1 select 0) + .25,
				(boundingBox _tVeh select 0 select 1),
				(_tVeh worldToModel (player modelToWorld _pTBC)) select 2
			]];
			player setDir 180; //Point at towed vehicle.
			player playMove "AmovPercMstpSnonWnonDnon_exercisePushup";
			sleep .5;

			//Create the offsets, attach.
			_x = (_aTBC select 0) - (_tTBC select 0);
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
			[objNull] execVM ""+ttl_loc+"TargetCtrl.sqf";
			[_tVeh] spawn ttl_carMon;
			if (-1 != _ID) then {player removeAction _ID};
		} else {titleText [format["%1 is not powerful enough to tow a %2", _tName, _aName], "PLAIN DOWN"]};
	} else {titleText [format["%1 cannot tow %2, already towing a %3",
						_tName, _aName, _tVeh getVariable ["TowedName", "<That ain't right>"]], "PLAIN DOWN"]};
} else {titleText [format["%1 is too far away from %2", _aName, _tName], "PLAIN DOWN"]};
