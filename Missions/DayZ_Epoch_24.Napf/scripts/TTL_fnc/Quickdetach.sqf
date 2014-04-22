//Usage: None
_tVeh 	= "";
_aVeh 	= "";
_ID		= _this select 2;
if (vehicle player getVariable ["isTowing", false]) then {
	_tVeh = _this select 0;
	_aVeh = _tVeh getVariable ["TowedObj", objNull];
} else {
	_aVeh = _this select 0;
	_tVeh = _aVeh getVariable ["TowedBy", objNull];
};
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
if (-1 != _ID) then {vehicle player removeAction _ID};
