player say "beep_strobe";

[missionNameSpace getVariable ["grad_gpsTracker_currentTarget", objNull],0.1,1,1,1,{100},-1] call grad_gpsTracker_fnc_openTitle;

player setVariable ["GRAD_GPSTRACKER_OPENED", true];
