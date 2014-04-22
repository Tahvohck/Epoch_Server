//Usage: [Action, Attaching vehicle]
_action	= objNull;
_aVeh	= objNull;
_lVeh 	= _this select 0;
_ID		= _this select 2;
_action = _this select 3 select 0;
_aVeh	= _this select 3 select 1;

switch (toLower _action) do {
	case "lift": {
		_aName	= getText (configFile >> "CfgVehicles" >> (typeOf _aVeh) >> "displayName");
		_lName	= getText (configFile >> "CfgVehicles" >> (typeOf _lVeh) >> "displayName");
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
			_z = -7.5;
			_aVeh attachTo [_lVeh, [_x,_y,_z]];
			
			//Set the relevant vehicle variables.
			_lVeh setVariable ["isTowing", true, true];
			_lVeh setVariable ["TowedObj", _aVeh, true];
			_lVeh setVariable ["TowedName", _aName, true];
			_aVeh setVariable ["TowedBy", _lVeh, true];
			_aVeh setVariable ["beingTowed", true, true];
			
			["cancel"] execVM ""+ttl_loc+"TargetCtrl.sqf";
			_lVeh removeAction _ID;
			ttl_LiftOp = -1;
		} else {titleText format["%1 is not powerful enough to lift a %2", _lName, _aName], "PLAIN DOWN"]};
	};
	case "drop": {
		_t		= velocity _aVeh;
		_vel 	= [_t select 0, _t select 2, _t select 1];
		_aVeh = _lVeh getVariable ["TowedObj", objNull];
		detach _aVeh;
		_aVeh setVelocity _vel;
		
		_lVeh setVariable ["isTowing", false, true];
		_lVeh setVariable ["TowedName", objNull, true];
		_lVeh setVariable ["TowedObj", objNull, true];
		_aVeh setVariable ["TowedBy", objNull, true];
		_aVeh setVariable ["beingTowed", false, true];
		_lVeh removeAction _ID;
		ttl_DropOp = -1;
	};
	default {diag_log format["%1", _action];};
};
