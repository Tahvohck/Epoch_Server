_death_record = [];
#include "\z\addons\dayz_server\compile\server_playerDied.sqf"

with profileNamespace do {
	StoredPDeaths = StoredPDeaths + [_death_record];
	if (count StoredPDeaths > 100) then {
		StoredPDeaths set ["", 0];
		StoredPDeaths - [""];
	};
};