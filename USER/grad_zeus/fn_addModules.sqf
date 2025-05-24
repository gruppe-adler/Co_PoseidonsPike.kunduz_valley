[] spawn {
    waitUntil {
        !isNull player
    };
    waitUntil {
        time > 3
    };
    {
        private _curator = _x;
        _curator addEventHandler ["CuratorgroupPlaced", {
            params ["", "_group"];
            ["Grad_missionControl_setServerAsowner", [_group]] call CBA_fnc_serverEvent;
        }];
        _curator addEventHandler ["CuratorObjectPlaced", {
            params ["", "_object"];
            if (_object isKindOf "CAManBase") then {
                if (count units _object == 1) then {
                    ["Grad_missionControl_setServerAsowner", [group _object]] call CBA_fnc_serverEvent;
                };
            } else {
                if (count crew _object > 1) then {
                    ["Grad_missionControl_setServerAsowner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
                };
            };
        }];
    } forEach allCurators;
};
["POSEIDONS PIKE", "1 - initial Briefing Dead drop", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. Task: Surveil identified dead drop code name TRASH. Purpose: Deny pickup by Courier, secure intel. Be-advised: drop-box is a blue plastic bin, Rough position marked on map. Be aware civilian density high. HAWK: insert SEAL no closer than 300 m, run nap-of-the-earth, 30 ft AGL, lights out. SEAL: select overwatch that won't spook target. Engage as soon as package is dropped. OVERLORD OUT.",
    "intel_1_dropbox", 39, true], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "2 - Upload intel complete, RTB", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. intel upload confirmed, decryption cycle running. Return to FOB, patch up and await further tasking. OVERLORD OUT.",
    "intel_2_uploadcomplete", 12, true], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "3 - Upload blank", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. USB stick is blank—no hidden partitions. Signal analysis traces the hardware batch to a local firm MEGAHARD DATA-SOLUTIONS, their main office is now marked SpiDER on your maps. Breach the premises, seize drives or paperwork that link the network. OVERLORD OUT.",
    "intel_3_uploadempty", 26, true], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "6 - Rebrief Bin Hoden decrypted", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. Full coordinate set for Bin HODENS compound decrypted. All elements RTB immediately for sand-table layout and re-brief. OVERLORD OUT.",
    "intel_6_rebrief", 14, true], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "7 - Open Hangar doors", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. Task: Surveil identified dead drop code name TRASH. Purpose: Deny pickup by Courier, secure intel. Be-advised: drop-box is a blue plastic bin, Rough position marked on map. Be aware civilian density high. HAWK: insert SEAL no closer than 300 m, run nap-of-the-earth, 30 ft AGL, lights out. SEAL: select overwatch that won't spook target. Engage as soon as package is dropped. OVERLORD OUT.",
    "intel_1_dropbox", 39, true], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "OVERLORD Custom Transmit", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    _position = ASLtoAGL _position;
    ["Example dialog", [["EDIT", "intel to send to players", "Your message for public briefing"]], {
        params [["_message", "..."], "_position"];
        [[_message#0, "none", 6, false], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    }, {
        systemChat "cancelled";
    }, _position] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;