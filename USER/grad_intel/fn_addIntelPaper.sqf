params ["_intel"];


private _text = "
----------------------------------------------------------------------
MEGAHARD / HAND CARRY - DO NOT RADIO
----------------------------------------------------------------------
REF  : K-Δ / RAVEN STRING
DATE : 25 MAY 25 - 1954Z
FROM : MACROHARD IMAGING CELL
TO   : OP-G HUMINT / O.BH

PAYLOAD FOLLOWS (B64 / KEY:   RAVEN22 ):

    MDQzIDA0NA==

HANDLER NOTES
•  Burn copy after one-time use.  
•  Courier-Bravo to confirm receipt by dropping empty USB at
   BAZAAR collection point.
----------------------------------------------------------------------
";




private _texture = "#(rgb,2048,2048,3)text(0,0,""LucidaConsoleB"",0.02,""#ffffff"",""#000000""," + _text + ")";
_intel setObjectTexture ["camo", _texture];

_intel setvariable ["bis_fnc_initInspectable_data",[_texture,_text,"",1]];

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
        {
            [_this select 0,true] call bis_fnc_initInspectable;
            ["missionControl_curatorInfo", [player, "paperintel", "complete"]] call CBA_fnc_globalEvent;
        },

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

