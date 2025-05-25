params ["_computer"];


private _text = "
\n\n\n
|-------------------------------------------------------------------\n
| MEGAHARD DATA-SOLUTIONS - SECURE TRANSFER LOG                     \n
|-------------------------------------------------------------------\n
|ID| Time (Z)     | Requestor      | AssetTag | Assigned Vehicle    \n
|-------------------------------------------------------------------\n
|77| 20:47:15.231| R. Lloyd       | USDS-024 | TAK-6969  \n
|78| 20:49:58.042| K. Ahmed       | USDS-025 | KBL-7315  \n
|79| 20:52:30.517| O. Bin Hoden   | CR-PACK  | LOSER1337 \n
|80| 20:55:04.811| M. Salim       | USDS-027 | TAK-401   \n
|81| 20:57:39.109| R. Lloyd       | USDS-028 | KBL-7204  \n
|82| 21:00:12.393| J. Bridges     | USDS-029 | KBL-7252  \n
|83| 21:02:37.004| K. Ahmed       | USDS-030 | TAK-402   \n
|84| 21:05:11.678| R. Singh       | USDS-031 | KBL-7350  \n
|85| 21:07:46.219| O. Bin Hoden   | CR-PACK  | LOSER1337 \n
|86| 21:10:28.543| M. Salim       | USDS-033 | TAK-410   \n
|87| 21:13:03.101| J. Bridges     | USDS-034 | KBL-7261  \n
|88| 21:15:29.776| R. Lloyd       | USDS-035 | KBL-7425  \n
|89| 21:18:04.290| O. Bin Hoden   | CR-PACK  | LOSER1337 \n
|90| 21:20:42.558| K. Ahmed       | USDS-037 | TAK-415   \n
|91| 21:23:17.640| R. Singh       | USDS-038 | KBL-7480  \n
|92| 21:25:50.912| O. Bin Hoden   | CR-PACK  | LOSER1337 \n
|93| 21:28:15.334| M. Salim       | USDS-040 | TAK-418   \n
|94| 21:30:48.907| J. Bridges     | USDS-041 | KBL-7299  \n
|95| 21:33:22.189| R. Lloyd       | USDS-042 | KBL-7502  \n
|96| 21:35:57.451| O. Bin Hoden   | CR-PACK  | LOSER1337 \n
|-------------------------------------------------------------------\n
\n\n\n
";




private _texture = "#(rgb,2048,2048,3)text(0,0,""EtelkaMonospaceProBold"",0.025,""#000000"",""#33ff33""," + _text + ")";

_computer setvariable ["bis_fnc_initInspectable_data",[_texture,_text,"",1]];

_computer setObjectTexture ["monitor", _texture];


[ 
 _computer, 
 "Access Computer", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3", 
 "_caller  distance _target < 3", 
 { params ["_target"];
	["Starting access...", 1, [1,1,1,1], true] call CBA_fnc_notify;
 }, 
 {  [] spawn {
			for "_i" from 1 to 2 do { 
				playSound3D [getMissionPath "USER\sounds\" + selectRandom ["keypad_1", "keypad_2", "keypad_3"] + ".ogg", player, true, getPosASL player, 10];
				sleep (0.1 + random 0.05);
		 	};
		};
		true
 }, 
 {
	params ["_target"];

    [_target, true] call bis_fnc_initInspectable;
	["missionControl_curatorInfo", [player, "pcaccess", "complete"]] call CBA_fnc_globalEvent;
},
 { 
	params ["_target"];

	["missionControl_curatorInfo", [player, "pcaccess", "aborted"]] call CBA_fnc_globalEvent;
	
	["Aborted access", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 1, nil, false, false 
] call BIS_fnc_holdActionAdd;
