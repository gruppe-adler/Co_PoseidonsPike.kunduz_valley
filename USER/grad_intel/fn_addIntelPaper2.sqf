params ["_intel"];


private _text = "\n\n\n\n
        ------------------------------------------------------\n
        SPAREBYTE / HAND CARRY - EYES ONLY\n
        ------------------------------------------------------\n
        REF  : PAK/LOVE2 / MOTHERLOAD\n
        DATE : 26 MAY 25 - 2205Z\n
        FROM : BLACKBYTE HUMINT CELL\n
        TO   : OP-L HUMINT / A. Hamdullilah\n
\n
        My sweetest Gulrukh,\n
        Each dawn I long to flee this courier life for your laughter,\n
        Yet my mother clings to my sleeve as if I were made of glass.\n
        \Stay with the network, she wails,we need you to deliver our hopes.\n
        And my father—God bless his stubborn bones—\n
        Insists a son's honor is tied to every package he carries,\n
        Not to the promises he breaks chasing love.\n
        They've drafted my destiny in ink thicker than bazaar oil—\n
        But here in the silent hours, pen in hand, I rewrite it all for you.\n
        Forgive me if this letter smells of ambush and regret,\n
        For the only raid I plan now is storming your smile.\n
\n
        --------------------------------------------------------\n
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
            ["missionControl_curatorInfo", [player, "paperintel2", "complete"]] call CBA_fnc_globalEvent;
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

