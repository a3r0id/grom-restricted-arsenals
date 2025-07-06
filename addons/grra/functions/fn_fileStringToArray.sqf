/*
	File: fn_fileStringToArray.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: 
        Syntax 1: ["file://path\to\file.sqf"] call GRRA_fnc_fileStringToArray;
        Syntax 2: ["file://path\to\file.sqf//path\to\another\file.sqf"] call GRRA_fnc_fileStringToArray;
    Returns: Array of strings
    Notes: 
        File should contain ONE valid array
        File should be in the format of ["item1", "item2", "item3"]
        This uses vanilla array parsing so it's not very robust, and must follow the above format.
        not to be confused with our [very] nieve parser, GRRA_fnc_strToArray.
*/

params ["_fileString"];
private _array = [];
{
    _array = _array + (call compile preprocessFileLineNumbers _x);
} forEach (([_fileString, "file://", ""] call CBA_fnc_replace) splitString "//");
_array




