/*
* Wird zum Missionsstart auf Server und Clients ausgeführt.
* Funktioniert wie die init.sqf.
*/

if (isServer) then {
    [planning_table, "mrk_final_compound", 20, 2, false, true, 0] remoteExec ["sebs_briefing_table_fnc_createTable", 0, planning_table];

    internetcafe animatesource ["Door_1", 1, true]; 
    internetcafe animatesource ["Door_4", 1, true]; 
    internetcafe animatesource ["Door_5", 1, true];

    uh80hangar setVariable ["bis_disabled_door_1", 1, true];
    uh80hangar setVariable ["bis_disabled_door_2", 1, true];
    uh80hangar setVariable ["bis_disabled_door_3", 1, true];
    uh80hangar setVariable ["bis_disabled_door_4", 1, true];
    uh80hangar setVariable ["bis_disabled_door_5", 1, true];
    uh80hangar setVariable ["bis_disabled_door_6", 1, true];
    uh80hangar setVariable ["bis_disabled_door_7", 1, true];
    uh80hangar setVariable ["bis_disabled_door_8", 1, true];
    uh80hangar setVariable ["bis_disabled_door_9", 1, true];
    uh80hangar setVariable ["bis_disabled_door_10", 1, true];
    uh80hangar setVariable ["bis_disabled_door_11", 1, true];
};

// fix for randomization breaking things
[] spawn {
    sleep 3;
    if (alive internetcafeuser1) then {
        [internetcafeuser1, "SIT", "NONE", chair1] call BIS_fnc_ambientAnim;
    };
    if (alive internetcafeuser2) then {
        [internetcafeuser2, "SIT", "NONE", chair2] call BIS_fnc_ambientAnim;
    };
    if (alive internetcafeuser3) then {
        [internetcafeuser3, "SIT", "NONE", chair3] call BIS_fnc_ambientAnim;
    };
    if (alive internetcafeuser4) then {
        [internetcafeuser4, "SIT", "NONE", chair4] call BIS_fnc_ambientAnim;
    };
    if (alive internetcafeuser5) then {
        [internetcafeuser5, "SIT", "NONE", chair5] call BIS_fnc_ambientAnim;
    };
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
