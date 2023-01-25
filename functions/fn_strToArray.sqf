/*
	File: fn_strToArray.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: [_str] call GRRA_fnc_strToArray -> array
*/

params ["_str"];
{
	_str = [_str, _x, ""] call CBA_fnc_replace;
} forEach [
	'"',
	"'",
	" ",
	"[",
	"]"
];
if (_str == "") exitWith {[]};
if ("," in _str) then {
	_str splitString ","
} else {
	[_str]
}