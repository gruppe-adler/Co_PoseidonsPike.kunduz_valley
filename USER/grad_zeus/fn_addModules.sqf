[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };

  {
    private _curator = _x;
    
      _curator addEventHandler ["CuratorGroupPlaced", {
          params ["", "_group"];

          ["GRAD_missionControl_setServerAsOwner", [_group]] call CBA_fnc_serverEvent;
      }];

      _curator addEventHandler ["CuratorObjectPlaced", {
          params ["", "_object"];

          if (_object isKindOf "CAManBase") then {
             if (count units _object == 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group _object]] call CBA_fnc_serverEvent;
             };
          } else {
             if (count crew _object > 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
             };
         };

      }];

  } forEach allCurators;
};


//////////////
////////////// CALLS
//////////////

["STO LEVIV - CALLS", "Ad hoc intel call (Input)",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

  _position = ASLtoAGL _position;

  ["Example Dialog", [["EDIT", "Intel to send via call", "Your message for public briefing"]], {
			params ["_message", "_position"]; 
      
      private _nearestPhone = objNull;
      private _nearestPhoneIndex = 0;
      private _allNumbers = missionNamespace getVariable ['GRAD_TELEPHONE_ALLNUMBERS', []];
      {
          private _phoneObjects = _x select 1;
          private _numberIndex = _forEachIndex;

          {
              private _phoneObject = _x;
              private _positionPhoneObject = position _x;

              if (isNull _nearestPhone) then {
                  _nearestPhone = _phoneObject;
              };

              if (_positionPhoneObject distance2D _position < (position _nearestPhone) distance2D _position) then {
                  _nearestPhone = _phoneObject;
                  _nearestPhoneIndex = _numberIndex;
              };
          } forEach _phoneObjects;
      } forEach _allNumbers;

      if (count _allNumbers < 1) exitWith { systemChat "No phones on map"; };

      [_nearestPhone, "GRAD_garble_long", _message#0] remoteExec ["GRAD_telephone_fnc_fakeCallPhone", 2];   
  
  }, { systemchat "cancelled"; }, _position] call zen_dialog_fnc_create;  

}] call zen_custom_modules_fnc_register;







/// POSEIDONS PIKE 

["POSEIDONS PIKE", "1 - Initial Briefing Dead drop",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    [
        ["SEAL-Actual, HAWK-One, this is OVERLORD. Task: Surveil identified dead drop code name TRASH. Purpose: Deny pickup by Courier, secure intel. Be-advised: Drop-box is a blue plastic bin, Rough position marked on map. Be aware civilian density high. HAWK: Insert SEAL no closer than 300 m; run nap-of-the-earth, 30 ft AGL, lights out. SEAL: Select overwatch that won’t spook target. Engage as soon as package is dropped. OVERLORD OUT.", 
        "intel_1_dropbox",
        39,
        true
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "2 - Upload Intel complete, RTB",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    [
        ["SEAL-Actual, HAWK-One, this is OVERLORD. Intel upload confirmed; decryption cycle running. Return to FOB, patch up and await further tasking. OVERLORD OUT.", 
        "intel_2_uploadcomplete",
        12,
        true
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;

["POSEIDONS PIKE", "3 - Upload blank",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    [
        ["SEAL-Actual, HAWK-One, this is OVERLORD. USB stick is blank—no hidden partitions.  Signal analysis traces the hardware batch to a local firm MEGAHARD DATA-SOLUTIONS; their main office is now marked SPIDER on your maps. Breach the premises, seize drives or paperwork that link the network. OVERLORD OUT.", 
        "intel_3_uploadempty",
        26,
        true
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;


["POSEIDONS PIKE", "6 - Rebrief Bin Hoden decrypted",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

    [
        ["SEAL-Actual, HAWK-One, this is OVERLORD. Full coordinate set for BIN HODENS compound decrypted. All elements RTB immediately for sand-table layout and re-brief. OVERLORD OUT.", 
        "intel_6_rebrief",
        14,
        true
    ], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];

}] call zen_custom_modules_fnc_register;




["POSEIDONS PIKE", "OVERLORD Custom Transmit",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

  _position = ASLtoAGL _position;

  ["Example Dialog", [["EDIT", "Intel to send to players", "Your message for public briefing"]], {
			params [["_message", "..."], "_position"]; 
      
            [[_message#0, "none", 6, false], "USER\rscMessage\createMessageRsc.sqf"] remoteExec ["BIS_fnc_execVM"];
  
  }, { systemchat "cancelled"; }, _position] call zen_dialog_fnc_create;  

}] call zen_custom_modules_fnc_register;


