_SAPre			= "SelfActions\";
_refreshPeriod	= 0.5;
_idx			= 0;
_Cyc_nObj		= (2/_refreshPeriod);

CSA_plr_selfBB	= -1;
_l_selfBBLoc	= (SCRIPT_LOCATION + _SAPre + "player_selfbloodbag.sqf");
CSA_drinkStanding	= -1;
_v_drSt_maxDist	= 5;
_l_drinkStatic	= (SCRIPT_LOCATION + _SAPre + "plr_drinkStanding.sqf");

_nearObj	= [];

while {1==1} do
{
	_playerPos	= getPosATL player;
	_mags		= magazines player;
	_vehicle	= vehicle player;
	_isPZombie	= player isKindOf "PZombie_VB";
	_inVehicle	= (_vehicle != player);
	_onLadder	= (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
	_canDo		= (!r_drag_sqf and !r_player_unconscious and !_onLadder);
	_canDrink	= false;
	
	if (_idx % _Cyc_nObj == 0) then {_nearObj = nearestObjects [_playerPos, [], 30]};
	_hasBloodBag = "ItemBloodbag" in _mags;
	
	// Krixes Self Bloodbag
	if((r_player_blood < 12000) && {_hasBloodBag} && {_canDo} && {speed player <= 1}) then {
		if (CSA_plr_selfBB < 0) then {
			CSA_plr_selfBB = player addAction[("<t color=""#c70000"">" + ("Self Bloodbag") +"</t>"),_l_selfBBLoc,"",5,false,true,"", ""];
		};
	} else {
		player removeAction CSA_plr_selfBB;
		CSA_plr_selfBB = -1;
	};
	//ESelfBB
	//StatDrink
	{
		if((_x distance _playerPos) < _v_drSt_maxDist)then{
			//If object is within standard distance, check if it's a non-pond
			_isWell = ["_well",str(_x)] call fnc_inString;
			if(_isWell)then{_canDrink = true};
			if(!_canDrink)then{
				_isPump = ["_pumpa",str(_x)] call fnc_inString;
				if(_isPump)then{_canDrink = true}};
			if(!_canDrink)then{
				_isWater = ["_water",str(_x)] call fnc_inString;
				if(_isWater)then{_canDrink = true}};
		};
		if !_canDrink then {
			//Different logic for pond searches, don't do if we don't have to.
			_isPond = ["pond",str(_x)] call fnc_inString;
			if (_isPond) then {
				_pondVert = (_x worldToModel _playerPos) select 2;
				if (_pondVert < 0) then {
					_canDrink = true;
		}}};
		if _canDrink exitWith {};
	} forEach _nearObj;
	
	if (_canDo && !_inVehicle && {_canDrink}) then {
		if (CSA_drinkStanding < 0) then {
			CSA_drinkStanding =  player addAction ["<t color='#3399FF'>Drink standing water</t>", _l_drinkStatic, [], 4, false]};
	}else{
		player removeAction CSA_drinkStanding;
		CSA_drinkStanding = -1;
	};
	
	//EStatDrink
	
	
	_idx = _idx+1;
	if (_idx > 1000) then {_idx = 0};
	sleep _refreshPeriod;
};
