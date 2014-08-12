_infectionChance = 75;

_owner	= _this select 0;
_owner removeAction CSA_drinkStanding;
CSA_drinkStanding = -1;

player playActionNow "PutDown";

dayz_lastDrink = time;
dayz_thirst = 0;

player setVariable ["messing", [dayz_hunger, dayz_thirst], true];
//drink sound, 6m radius
[player,"drink",0,false,6] call dayz_zombieSpeak;

if (random 100 <= _infectionChance) then {
    r_player_infected = true;
    player setVariable["USEC_infected",true,true];
};

//Ensure Control is visible
_display = uiNamespace getVariable 'DAYZ_GUI_display';
(_display displayCtrl 1302) ctrlShow true;
