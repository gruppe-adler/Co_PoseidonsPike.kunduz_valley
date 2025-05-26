params ["_intel"];


private _text = "\n\n\n\n
        ---------------------------------------------------------\n
        SPAREBYTE / HAND CARRY - EYES ONLY\n
        ---------------------------------------------------------\n
        REF  : PAK/LOVE / BAZAAR BOUQUET\n
        DATE : 26 MAY 25 - 2150Z\n
        FROM : CELL SHENANIGANS\n
        TO   : OP-L HUMINT / A. Hamdullilah\n
\n
        My dearest Gulrukh,\n
        I burn for you like a roadside matchstick,\n
        Even the dust-choked winds of Kandahar fail to smother this flame.\n
        Your smile hides more danger than a checkpoint at dawn:\n
        I'd brave a thousand curfews just to glimpse your jalebi-sweet grin.\n
        Yet they say a man in these parts must own goats, land, and a patron;\n
        I only possess this battered pen and the ghost of my last paycheck.\n
        If love were weapons-grade, I'd rain poetry over Peshawar—\n
        But instead, I'm stuck crafting verses in the dark,\n
        Hoping you find this note
\n\n\n
";




private _texture = "#(rgb,2048,2048,3)text(0,0,""LucidaConsoleB"",0.018,""#ffffff"",""#000000""," + _text + ")";
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
            ["missionControl_curatorInfo", [player, "paperintel3", "complete"]] call CBA_fnc_globalEvent;
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

