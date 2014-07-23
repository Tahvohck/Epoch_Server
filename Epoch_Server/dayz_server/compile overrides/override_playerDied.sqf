_death_record = [];
#include "\z\addons\dayz_server\compile\server_playerDied.sqf"

with profileNamespace do {
	if (isNil "StoredPDeaths") then { StoredPDeaths = [] };
	StoredPDeaths = StoredPDeaths + [_death_record];
	if (count StoredPDeaths > 100) then {
		StoredPDeaths set ["", 0];
		StoredPDeaths - [""];
	};
};


_Killed = _this select 2;

_pause = 60 + floor random 121;

_n1 = 2 + floor random 2;
_r1 = 15 + floor random 11;
_h1 = 15 + floor random 11;

_n2 = 3 + floor random 4;
_r2 = 20 + floor random 21;
_h2 = 30 + floor random 21;

[_Killed, _n1, _pause, _r1, _h1] spawn TAHV_CrowsAfterWait;
diag_log formatText["CROWS: Spawning %1 crows %2m high and %3m wide after %4 seconds.", _n1, _r1, _h1, _pause];
[_Killed, _n2, _pause, _r2, _h2] spawn TAHV_CrowsAfterWait;
diag_log formatText["CROWS: Spawning %1 crows %2m high and %3m wide after %4 seconds.", _n2, _r2, _h2, _pause];	