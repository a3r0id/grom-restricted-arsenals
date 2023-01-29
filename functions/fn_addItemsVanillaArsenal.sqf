/*
	File: fn_addItemsVanillaArsenal.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: (postInit) GRRA_fnc_addItemsVanillaArsenal;
*/

params["_box", "_itemsAll"];

private _itemClasses     	= [];
private _weaponClasses   	= [];
private _magazineClasses 	= [];
private _backpackClasses 	= [];
private _vestClasses    	= [];
private _binocularClasses 	= [];

{
	// Backpacks
    if (getNumber (configFile >> "CfgVehicles" >> _x >> "isBackpack") == 1) then {
		_backpackClasses pushBack _x;
		continue;
	};
// https://github.com/acemod/ACE3/blob/76676eee462cb0bbe400a482561c148d8652b550/addons/common/functions/fnc_getItemType.sqf
	
	private _type = [_x] call ace_common_fnc_getItemType;

	// Vests
	if (_type#1 == "vest") then {
		_vestClasses pushBack _x;
		continue;
	};

	// Binoculars
	if (_type#1 == "binocular") then {
		_binocularClasses pushBack _x;
		continue;
	};	

	// Weapons
	if (_type#0 == "weapon") then {
		_weaponClasses pushBack _x;
		continue;
	};		

	// Magazines
	if (_type#0 == "magazine") then {
		_magazineClasses pushBack _x;
		continue;
	};

	// Items + everything else
	_itemClasses pushBack _x;

} forEach _itemsAll;

["AmmoboxInit",[_box]] spawn BIS_fnc_arsenal;
[_box, _itemClasses, false, true,     1, 0]     call BIS_fnc_addVirtualItemCargo;
[_box, _weaponClasses, false, true,   1, 1]     call BIS_fnc_addVirtualItemCargo;
[_box, _magazineClasses, false, true, 1, 2]     call BIS_fnc_addVirtualItemCargo;
[_box, _backpackClasses, false, true, 1, 3]     call BIS_fnc_addVirtualItemCargo;
[_box, _binocularClasses]    					call BIS_fnc_addVirtualItemCargo;
[_box, _vestClasses]     						call BIS_fnc_addVirtualItemCargo;