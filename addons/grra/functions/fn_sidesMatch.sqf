/*
	File: fn_sidesMatch.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: [_definedSideValue] call GRRA_fnc_sidesMatch -> bool
*/

params ["_definedSideValue"];
_definedSide = side player; // init w/ any (player's side)
switch (_definedSideValue) do {
	case 0: {_definedSide = side player};
	case 1: {_definedSide = west};
	case 2: {_definedSide = east};
	case 3: {_definedSide = independent};
	case 4: {_definedSide = civilian};
};
(side player isEqualTo _definedSide)