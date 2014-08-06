_SAPre = "SelfActions\";
_refreshPeriod = 0.5;
_idx = 0;

CSA_plr_selfBB = -1;
_l_selfBBLoc = (SCRIPT_LOCATION + _SAPre + "player_selfbloodbag.sqf");

while {1==1} do
{
	_mags = magazines player;
	_vehicle = vehicle player;
	_isPZombie = player isKindOf "PZombie_VB";
	_inVehicle = (_vehicle != player);
	_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
	_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);
	
	_hasBloodBag = "ItemBloodbag" in _mags;
	
	// Krixes Self Bloodbag
	if((r_player_blood < 12000) && {_hasBloodBag} && {_canDo} && {(speed player <= 1)}) then {
		if (CSA_plr_selfBB < 0) then {
			CSA_plr_selfBB = player addAction[("<t color=""#c70000"">" + ("Self Bloodbag") +"</t>"),_l_selfBBLoc,"",5,false,true,"", ""];
		};
	} else {
		player removeAction CSA_plr_selfBB;
		CSA_plr_selfBB = -1;
	};
	//ESelfBB
	
	
	_idx = _idx+1;
	if (_idx > 1000) then {_idx = 0};
	sleep _refreshPeriod;
};
