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
                    if (side _object == civilian) then {
                        _object removeItems "Binocular";
                    };
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
    "intel_1_dropbox", 39], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "1.5 - Walk To Deaddrop", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    
    if (!isPlayer _objectUnderCursor && _objectUnderCursor isKindOf "Man") then {
        [_objectUnderCursor] remoteExec ["grad_intel_fnc_walkToDeaddrop", 2];
    };
}] call zen_custom_modules_fnc_register;


["POSEIDONS PIKE", "2 - Upload intel task", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, this is OVERLORD. We have no time to lose, upload the intel at the nearest internet café. HQ needs it now. OVERLORD out.",
    "intel_2_upload", 8], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "3 - Upload blank", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, this is OVERLORD. Interim report on upload: file came up empty. Analysts confirm transfer completed; content simply is not there. We're pivoting to the stick itself—SIGINT and forensics are pulling the hardware fingerprint for hidden partitions or firmware traps. Expect update in roughly five mikes. For now, return to FOB. OVERLORD out.",
    "intel_3_uploadempty", 21], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "4 - Task Spider", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, this is OVERLORD. Update on stick forensics: the controller ID of the stick is a custom run built exclusively for MACROHARD ELECTRONICS. Firmware shows ghost-partitions addressed only by their in-house imaging rig. Task: breach MACROHARD HQ (marker SPIDER added to map), seize any intel that connects us to Bin Hoden. OVERLORD out.",
    "intel_4_task_spider", 24], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    "mrk_spider" setMarkerAlpha 1;
    missionNameSpace setVariable ["macrohard_enemies", true, true];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "5 - Task Track", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, this is OVERLORD. Find vehicle plate LOSER 1337, hard-plant the Adlell GPS tracker beneath the chassis, then shadow the truck to its final stop. Do not engage or spook the driver. Infiltrate his hideout and find any evidence for the connection to Bin Hoden. OVERLORD out.",
    "intel_5_task_track", 18], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    missionNameSpace setVariable ["terrorcell_enemies", true, true];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "5.5 - Terrorcell Reinfs", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    
    missionNameSpace setVariable ["terrorcell_reinforcements", true, true];
}] call zen_custom_modules_fnc_register;




["POSEIDONS PIKE", "6 - Rebrief Bin Hoden decrypted", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. Full coordinate set for Bin HODENS compound decrypted. All elements RTB immediately for sand-table layout and re-brief in front of southern hangar. OVERLORD OUT.",
    "intel_6_rebrief", 14], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    "mrk_binhoden" setMarkerAlpha 1;
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "7.1 - Open Hangar doors", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    
    [] execVM "User\scripts\hangar_lights\openHangarDoor.sqf";
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "7.2 - Toggle Hangar Lights", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    
    ["User\scripts\hangar_lights\toggleHangarLights.sqf"] remoteExec ["execVM", 0, true];
}] call zen_custom_modules_fnc_register;


["POSEIDONS PIKE", "8 - Crash Land ANY Heli", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    
    private _heli = nearestObject [ASLtoAGL _position, "Air"];
    if (isNull _heli) exitWith { "No heli found" call CBA_fnc_notify; };

    private _smoke = "test_EmptyObjectForSmoke" createVehicle position _heli;
    _smoke attachTo [_heli ,[0,-6.5,2]];

    _heli setHitpointDamage ["HitVRotor",0.85];
    _heli setHitpointDamage ["HitBattery",0.85];
    _heli setHitpointDamage ["HitFuel",1];

    _heli allowDamage false;

    [{
        params ["_heli"];
        isTouchingGround _heli;
    },{
        params ["_heli"];
        _heli setFuel 0;
        [_heli] spawn { params ["_heli"]; sleep 3; _heli allowDamage true; };
    }, [_heli]] call CBA_fnc_waitUntilAndExecute;

}] call zen_custom_modules_fnc_register;


["POSEIDONS PIKE", "9a - Crash confirm and Hold out", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. ISR feed confirms your Stealth-bird crash-landed inside compound. Task: rig the airframe for total denial. Militia QRF converging from the highway, ETA three mikes. Hold your perimeter until exfil. Command will dispatch relief. OVERLORD out.",
    "intel_9a_crashland", 19], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "9b - Hold out", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL-Actual, HAWK-One, this is OVERLORD. Militia QRF converging from the highway, ETA three mikes. Hold your perimeter until exfil. Command will dispatch relief. OVERLORD out.",
    "intel_9b_land", 11], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
}] call zen_custom_modules_fnc_register;


["POSEIDONS PIKE", "9c - Send police", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    missionNameSpace setVariable ["binhoden_reinforcements", true, true];
   
}] call zen_custom_modules_fnc_register;



["POSEIDONS PIKE", "10 Congrats and RTB", {
    params [["_position", [0, 0, 0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
    [["SEAL Actual, HAWK One, this is OVERLORD. Geronimo Omega confirmed, Bin Hoden is eliminated. Outstanding work. Entire task force is green across the board. Rally at LZ for final lift; lights cold, two-minute window. JSOC conveys its congratulations. Debrief and cold ones waiting on board the USS Freedom at 065 107. OVERLORD out.",
    "intel_10_returntouss", 25], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
    missionNameSpace setVariable ["carrier", true, true];
   
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



["POSEIDONS PIKE Ambient", "Music Radio",
    {
      // Get all the passed parameters
      params ["_position", "_object"];
      _position = ASLToAGL _position;

      private _radio = (selectRandom ["land_gm_euro_furniture_radio_01", "jbad_radio_b", "Land_FMradio_F"]) createVehicle [0,0,0];
      _radio setPos _position;
      _radio setDir (random 360);

      private _source = createSoundSource [(selectRandom ["arabicsong1", "arabicsong2"]), _position, [], 0];
      [_source, _radio, false] call grad_ambient_fnc_soundSourceHelper;
      
      {
        _x addCuratorEditableObjects [[_radio], false];
      } forEach allCurators;

    }] call zen_custom_modules_fnc_register;