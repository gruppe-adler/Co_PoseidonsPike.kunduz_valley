/*
* Wird zum Missionsstart auf Server und Clients ausgeführt.
* Funktioniert wie die init.sqf.
*/

if (isServer) then {
    [planning_table, "mrk_final_compound", 20, 2, false, true, 0] remoteExec ["sebs_briefing_table_fnc_createTable", 0, planning_table];

    internetcafe animatesource ["Door_1", 1, true]; 
    internetcafe animatesource ["Door_4", 1, true]; 
    internetcafe animatesource ["Door_5", 1, true];

    // add healing in vehicles
    ["Air", "init", {
        params ["_vehicle"];

        [_vehicle] call grad_vehiclehealing_fnc_addVehicleHeal;

    }, true, [], true] call CBA_fnc_addClassEventHandler;
};


// 
[{
    params ["_args", "_handle"];

    if (sunOrMoon < 0.2) then {
        setAperture 4;
    } else {
        setAperture -1;
        if (missionNamespace getVariable ["grad_brighternight_panichandle", false]) then {
            [_handle] call CBA_fnc_removePerFramehandler;
        };
    };
    
}, 1, []] call CBA_fnc_addPerFrameHandler;