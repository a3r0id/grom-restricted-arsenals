/*
	File: fn_cleanArsenalBox.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: [_arsenalBox] call GRRA_fnc_cleanArsenalBox -> nil
*/

params ["_arsenalBox"];
clearMagazineCargoGlobal _arsenalBox;
clearItemCargoGlobal     _arsenalBox;
clearBackpackCargoGlobal _arsenalBox;
clearWeaponCargoGlobal   _arsenalBox;
[_arsenalBox, false] call ace_arsenal_fnc_removeBox;
//_arsenal setVariable ["ace_cargo_noRename", true];	
