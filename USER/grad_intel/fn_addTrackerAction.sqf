["Car", "init", {
        params [["_vehicle", objNull]];

        diag_log format ["added tracker action to %1", _vehicle];
        [_vehicle] call grad_intel_fnc_addTrackerToVehicle;

}, true, [], true] call CBA_fnc_addClassEventHandler;



private _onAction = {
    [] call grad_intel_fnc_showTracker;
};

private _condition = {
    !((_this select 0) getVariable ["GRAD_GPSTRACKER_OPENED",false])
};

private _action = ["GRAD_showTracker", "Show GPS Tracker", "\a3\ui_f\data\igui\cfg\holdactions\holdaction_connect_ca.paa", _onAction, _condition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;	



private _onAction2 = {
    [] call grad_gpsTracker_fnc_closeTitle;
	player setVariable ["GRAD_GPSTRACKER_OPENED", false];
};

private _condition2 = {
    ((_this select 0) getVariable ["GRAD_GPSTRACKER_OPENED",false])
};

private _action2 = ["GRAD_showTracker", "Hide Tracker", "\a3\ui_f\data\igui\cfg\holdactions\holdaction_connect_ca.paa", _onAction2, _condition2] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action2] call ace_interact_menu_fnc_addActionToObject;	
