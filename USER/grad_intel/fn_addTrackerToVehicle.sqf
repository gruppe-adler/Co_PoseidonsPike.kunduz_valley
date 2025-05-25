params ["_vehicle"];

[ 
 _vehicle, 
 "Add GPS Tracker to Vehicle", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3", 
 "_caller  distance _target < 3", 
 { params ["_target"];
	["Adding GPS Tracker...", 1, [1,1,1,1], true] call CBA_fnc_notify;
 }, 
 {
		true
 }, 
 {
	params ["_target"];
	private _currentlyTrackedVehicle = missionNameSpace getVariable ["grad_gpsTracker_currentTarget", objNull];

    if (_currentlyTrackedVehicle == _target) exitWith {
        "This vehicle already is tracked" call CBA_fnc_notify;
    };

    missionNameSpace setVariable ["grad_gpsTracker_currentTarget", _target, true];

    "Added GPS Tracker to vehicle" call CBA_fnc_notify;

	["missionControl_curatorInfo", [player, "trackeradded", "complete"]] call CBA_fnc_globalEvent;

},
 { 
	params ["_target"];
	
	["Aborted tracker addition", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 10, nil, false, false 
] call BIS_fnc_holdActionAdd;