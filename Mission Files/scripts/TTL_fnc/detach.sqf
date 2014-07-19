_aVeh = _this select 3 select 0;
_tVeh = _aVeh getVariable["TowedBy", objNull];

_t		= velocity _aVeh;
_vel 	= [_t select 0, _t select 1, (_t select 2) - 0.5];
detach _aVeh;

_aVeh setVelocity _vel;
_tVeh setVariable ["isTowing", false, true];
_tVeh setVariable ["TowedName", objNull, true];
_tVeh setVariable ["TowedObj", objNull, true];
_aVeh setVariable ["TowedBy", objNull, true];
_aVeh setVariable ["beingTowed", false, true];
vehicle player removeAction ttl_UntowOp;
ttl_UntowOp = -1;
diag_log formatText["TAHV_TTL: Velocity of detaching: %1", _vel];