/*
* Wird zum Missionsstart auf Server und Clients ausgeführt.
* Funktioniert wie die init.sqf.
*/

if (isServer) then {
    [planning_table, "mrk_final_compound", 20, 2, false, true, 0] remoteExec ["sebs_briefing_table_fnc_createTable", 0, planning_table];



    private _licenseplate = "LOS-ER 1337";
    courierCar setobjecttextureglobal ["LicensePlate", _licenseplate];
};