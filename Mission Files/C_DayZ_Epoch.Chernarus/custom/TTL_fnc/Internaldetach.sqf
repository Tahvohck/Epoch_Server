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

_tVeh setVariable ["isTowing", false, true];
_tVeh setVariable ["TowedName", objNull, true];
_tVeh setVariable ["TowedObj", objNull, true];
vehicle player removeAction _ID;

_vel = "";
_tVel = "";
if (!isNull _aVeh) then {
	_t		= velocity _aVeh;
	_vel 	= [_t select 0, _t select 1, (_t select 2) + 0.5];
	_t		= velocity _tVeh;
	_tVel 	= [_t select 0, _t select 1, (_t select 2)];
	detach _aVeh;
	_aVeh setVariable ["TowedBy", objNull, true];
	_aVeh setVariable ["beingTowed", false, true];
};
_aVeh setVelocity _vel;
diag_log formatText["TAHV_TTL: Velocity of detaching: %1", _vel];
diag_log formatText["TAHV_TTL: Velocity tow/lifting: %1", _tVel];