params ["_unit"];

if (isServer) then {

    _unit setUnitLoadout [[],[],[],["UK3CB_TKC_C_U_03_B",[]],["UK3CB_V_Invisible_Plate",[]],[],"UK3CB_TKC_H_Turban_03_1","fsob_Beard01_Light",[],["","","","","ItemWatch",""]];

    [_unit, "PersianHead_A3_01", "Male01PER", 1.05, "Osama Bin Hoden"] call BIS_fnc_setIdentity;

};