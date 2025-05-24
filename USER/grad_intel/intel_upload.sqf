params ["_intel"];


private _text = "
 \nTOP SECRET\n\n
From: Office of Naval Intelligence, Financial Surveillance Division\n
To: [Redacted]\n
Subject: Financial Transfers – Kraken Command\n
Date: 2035-04-01\n\n
Summary of Transactions:\n\n
Transaction 1:\n
Sender: Igor Volkov (Russian Armed Forces, Special Account 3221)\n
Receiver: Offshore Account #8412 [Name Redacted]\n
Amount: $250,000 USD\n
Date: Date: 2035-04-03\n
Note: Operation Kraken – Initial Phase\n\n
Transaction 2:\n
Sender: Igor Volkov (Russian Armed Forces, Special Account 3221)\n
Receiver: [Redacted American Bank Account #XXXX]\n
Amount: $500,000 USD\n
Date: Date: 2035-05-27\n
Note: Recon Reports and Movement Intel – Cleared for Kraken\n\n
Transaction 3:\n
Sender: Volkov Holdings (Russian Front Company)\n
Receiver: [Redacted]\n
Amount: $150,000 USD\n
Date: 2035-06-01\n
Note: Completion Bonus – Operation Success Pending\n
";




private _texture = "#(rgb,2048,2048,3)text(0,0,""LucidaConsoleB"",0.025,""#000000"",""#33ff33""," + _text + ")";

_intel setvariable ["bis_fnc_initInspectable_data",[_texture,_text,"",1]];

_intel setObjectTexture ["monitor", _texture];
_intel setObjectTexture ["pad", "data\putin2.paa"];


//--- Add action
if (isnil {_intel getvariable "bis_fnc_initInspectable_actionID"}) then {
    private _actionID = [
        //--- 0: Target
        _intel,

        //--- 1: Title
        localize "STR_A3_Functions_F_Orange_Examine",

        //--- 2: Idle Icon
        "\a3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa",

        //--- 3: Progress Icon
        "\a3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa",

        //--- 4: Condition Show
        "_this distance _target < 3",

        //--- 5: Condition Progress
        nil,

        //--- 6: Code Start
        {},

        //--- 7: Code Progress
        {
            _progressTick = _this select 4;
            if (_progressTick % 2 == 0) exitwith {};
            playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
        },

        //--- 8: Code Completed
        {[_this select 0,true] call bis_fnc_initInspectable;},

        //--- 9: Code Interrupted
        {},

        //--- 10: Arguments
        [],

        //--- 11: Duration
        0.5,

        //--- 12: Priority
        nil,

        //--- 13: Remove When Completed
        false
    ] call bis_fnc_holdActionAdd;
    _intel setvariable ["bis_fnc_initInspectable_actionID",_actionID];
};




params ["_computer"];

[ 
 _computer, 
 "Upload Intel", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3 && !(_target getVariable ['GRAD_intel_upload_done', false]) &&
 [_this, 'FlashDisk'] call bIs_fnc_hasitem", 
 "_caller  distance _target < 3", 
 { ["Starting upload...", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  [] spawn {
			for "_i" from 1 to 2 do { 
				playSound3D [getMissionPath "USER\sounds\" + selectRandom ["keypad_1", "keypad_2", "keypad_3"] + ".ogg", player, false, getPosASL player, 5] remoteExec ["say3D", 20];
				sleep (0.05 + random 0.05);
		 	};
		};
		true
 }, 
 {
	params ["_target"];
	_target setVariable ['GRAD_intel_upload_done', true, true];
	["Intel upload finished.", 1, [1,1,1,1], true] call CBA_fnc_notify;

	[_target, "USER\scripts\uploadIntel.sqf"] remoteExec ["BIS_fnc_execVM"];

	["GRAD_intel_upload_completed", []] call CBA_fnc_globalEvent;

	[_target, "USER\grad_intel\intel_rickroll.sqf"] remoteExec ["BIS_fnc_execVM", 0, true];
},
 { ["Aborted upload", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 10, nil, false, false 
] call BIS_fnc_holdActionAdd;

[ 
 _computer, 
 "Inspecting Laptop", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3 && !(_target getVariable ['GRAD_intel_upload_done', false]) &&
 !([_this, 'FlashDisk'] call bIs_fnc_hasitem)", 
 "_caller  distance _target < 3", 
 { ["Taking a look..", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  }, 
 {
	params ["_target"];
	["If I had something to stick into the data slot, I would do it.", 1, [1,1,1,1], true] call CBA_fnc_notify;
},
 { ["Aborted inspect", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 1, nil, false, false 
] call BIS_fnc_holdActionAdd;

// caching of the textures to prevent flickering later on
[_computer, "USER\scripts\uploadIntel.sqf"] remoteExec ["BIS_fnc_execVM"];