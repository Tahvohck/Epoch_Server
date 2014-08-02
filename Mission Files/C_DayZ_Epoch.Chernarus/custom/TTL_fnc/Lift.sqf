//Usage: [Attaching vehicle]
_lVeh 	= _this select 0;
_ID		= _this select 2;
_aVeh	= _this select 3 select 0;

_aName	= getText (configFile >> "CfgVehicles" >> (typeOf _aVeh) >> "displayName");
_lLiftClass = [_lVeh, ttl_canLift] call ttl_gCorClass;
_aVehW	= [_aVeh, ttl_weightClass] call ttl_gCorClass;
if (_lLiftClass >= _aVehW) then {
	//True bounding centers. boundingCenter returns an [x,z,y] Array.
	_t = boundingCenter _aVeh;
	_aTBC = [_t select 0, _t select 2, _t select 1];
	_t = boundingCenter _lVeh;
	_tTBC = [_t select 0, _t select 2, _t select 1];
	_t = nil;

	//Create the offsets, attach.
	_x = (boundingCenter _aVeh select 0) - (boundingCenter _lVeh select 0);
	_y = (boundingCenter _aVeh select 0) - (boundingCenter _lVeh select 0);
	_z = -5 - sqrt sizeOf typeOf _aVeh;
	_aVeh attachTo [_lVeh, [_x,_y,_z]];
	
	//Set the relevant vehicle variables.
	_lVeh setVariable ["isTowing", true, true];
	_lVeh setVariable ["TowedObj", _aVeh, true];
	_lVeh setVariable ["TowedName", _aName, true];
	_aVeh setVariable ["TowedBy", _lVeh, true];
	_aVeh setVariable ["beingTowed", true, true];
	
	[objNull] execVM ""+ttl_loc+"TargetCtrl.sqf";
	_lVeh removeAction _ID;
	ttl_LiftOp = -1;
} else {
	_lName	= getText (configFile >> "CfgVehicles" >> (typeOf _lVeh) >> "displayName");
	titleText [format["%1 is not powerful enough to lift a %2", _lName, _aName], "PLAIN DOWN"]
};
