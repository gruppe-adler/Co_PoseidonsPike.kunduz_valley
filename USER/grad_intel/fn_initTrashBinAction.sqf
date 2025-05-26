
 ["ace_dragging_stoppedCarry", {
    params ["_unit", "_target", "_loadCargo"];

    private _trashcans = [
            "land_gm_euro_misc_trashbin_01_blk",
            "land_gm_euro_misc_trashbin_01_blu",
            "land_gm_euro_misc_trashbin_01_brn",
            "land_gm_euro_misc_trashbin_01_grn",
            "land_gm_euro_misc_trashbin_01_red",
            "land_gm_euro_misc_trashbin_01_ylw"
    ];

    // systemchat str (typeof _target);

    if (typeof _target in _trashcans) then {
        // systemchat "success";

        private _garbagetruck = nearestObject [position _target, "gm_ge_civ_u1300l"];
        if (!isNull _garbagetruck) then {
            private _distance = _target distance _garbagetruck;
            systemchat str _distance;
            if (_distance < 3) then {
                _garbagetruck setVehicleCargo _target;
            };
        };
        
    };
    
}] call CBA_fnc_addEventhandler;

if (!isServer) exitWith {};

{
    [_x, "init", {
        params ["_vehicle"];
        [_vehicle] call grad_intel_fnc_addTrashBinAction;
        // systemChat "log";
    },
    true,   // multicast to all machines
    [],     // no extra args
    true    // preInit: inject before init runs
    ] call CBA_fnc_addClassEventHandler;
} forEach [
        "land_gm_euro_misc_trashbin_01_blk",
        "land_gm_euro_misc_trashbin_01_blu",
        "land_gm_euro_misc_trashbin_01_brn",
        "land_gm_euro_misc_trashbin_01_grn",
        "land_gm_euro_misc_trashbin_01_red",
        "land_gm_euro_misc_trashbin_01_ylw"
];