uiNamespace setVariable ["GFC_ITEMS_ALL", call GRRA_fnc_aceGetAllCfgItems];
with uiNamespace do 
{

	disableSerialization; 

	GFC_COLOR_WHITE 		= [0.8, 0.8, 0.8, 1];
	GFC_COLOR_WHITE_FULL 	= [1, 1, 1, 1];
	GFC_COLOR_BLACK 	 	= [0, 0, 0, 1];
	GFC_COLOR_GREEN 	 	= [0, 0.6, 0, 1];
	GFC_COLOR_RED 		 	= [0.6, 0, 0, 1];

	GRRA_FNC_SETTEXT = {
		params ["_control", "_text"];
		_control ctrlSetText _text;
		_control ctrlCommit 0;
	};

	IDC_EDIT_BOX = 123;

	// hold instances of currently displayed listbox types   (BTN)
	GFC_CURRENT_TYPES      = [];

	// hold instances of currently displayed listbox options (BTN)
	GFC_CURRENT_OPTIONS      = [];

	// load last arsenal
	GFC_MY_CURRENT_ARSENAL   = profileNamespace getVariable ["GFC_MY_CURRENT_ARSENAL", []];

	_displays = [];
	{
		_displays pushBack ((str _x) splitString "#")#1; 
	} forEach allDisplays;

	if !("313" in _displays) then {
		// ingame
		waitUntil { !isNull (findDisplay 46) }; 
		GFC_DISPLAY = (findDisplay 46) createDisplay "RscDisplayEmpty";
	} else {
		// 3den
		GFC_DISPLAY = (findDisplay 313) createDisplay "RscDisplayEmpty";
	};

	GFC_DISPLAY = (findDisplay 313) createDisplay "RscDisplayEmpty"; 
	GFC_DISPLAY displaySetEventHandler ["onUnload", "hint 'Formatter unloaded!';"];

	GFC_CONTROL_GROUP = GFC_DISPLAY ctrlCreate ["RscControlsGroup", -1];	
	GFC_CONTROL_GROUP ctrlSetPosition [safeZoneW * 0.005, safeZoneH * 0.015];
	GFC_CONTROL_GROUP ctrlCommit 0;		

	GFC_CONTROL_BG = GFC_DISPLAY ctrlCreate ["RscTextMulti", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_BG ctrlEnable false;
	GFC_CONTROL_BG ctrlSetPosition [0, 0, 1, 1];
	GFC_CONTROL_BG ctrlSetBackgroundColor GFC_COLOR_BLACK;
	GFC_CONTROL_BG ctrlCommit 0;

	GFC_CONTROL_TEXT_BOX = GFC_DISPLAY ctrlCreate ["RscEditMulti", IDC_EDIT_BOX, GFC_CONTROL_GROUP];
	GFC_CONTROL_TEXT_BOX ctrlSetFont "RobotoCondensedLight";
	GFC_CONTROL_TEXT_BOX ctrlSetPosition [safeZoneW * 0.015, safeZoneH * 0.02, safeZoneW * 0.3, safeZoneH * 0.75];
	GFC_CONTROL_TEXT_BOX ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
	GFC_CONTROL_TEXT_BOX ctrlEnable false;
	GFC_CONTROL_TEXT_BOX ctrlCommit 0;

	// button-set  [COPY] [IMPORT] [CLEAR]
	GFC_CONTROL_BTN_EXPORT = GFC_DISPLAY ctrlCreate ["RscButtonMenu", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_BTN_EXPORT ctrlSetPosition [safeZoneW * 0.015, safeZoneH * 0.78, safeZoneW * 0.08, safeZoneH * 0.05];
	GFC_CONTROL_BTN_EXPORT ctrlSetStructuredText parseText "<t shadow='2' valign='center' color='#FFFFFF' align='center'>EXPORT</t>";
	GFC_CONTROL_BTN_EXPORT ctrlSetTooltip "Export the current arsenal array to clipboard";
	GFC_CONTROL_BTN_EXPORT ctrlAddEventHandler ["ButtonClick", {
		with uiNamespace do {
			copyToClipboard (str GFC_MY_CURRENT_ARSENAL);
			["Exported to clipboard!", 2] call GRRA_FNC_NOTIFICATION;
		};
	}];
	GFC_CONTROL_BTN_EXPORT ctrlCommit 0;

	GFC_CONTROL_BTN_IMPORT = GFC_DISPLAY ctrlCreate ["RscButtonMenu", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_BTN_IMPORT ctrlSetPosition [safeZoneW * 0.125, safeZoneH * 0.78, safeZoneW * 0.08, safeZoneH * 0.05];
	GFC_CONTROL_BTN_IMPORT ctrlSetStructuredText parseText "<t shadow='2' valign='center' color='#FFFFFF' align='center'>IMPORT</t>";
	GFC_CONTROL_BTN_IMPORT ctrlSetTooltip "DISABLED IN MP: Import an arsenal array from clipboard";
	GFC_CONTROL_BTN_IMPORT ctrlAddEventHandler ["ButtonClick", {
		with uiNamespace do {
			_clip = copyFromClipboard;
			if (_clip isEqualTo "") exitWith { ["Clipboard is empty or in MP game!", 2] call GRRA_FNC_NOTIFICATION; };
			GFC_MY_CURRENT_ARSENAL = [];
			[] call GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI;	
			GFC_MY_CURRENT_ARSENAL = [_clip] call GRRA_fnc_strToArray;
			[] call GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI;
			[] call GRRA_FNC_DELEGATE_CURRENT_ITEMS_LIST;
			["Imported from clipboard!", 2] call GRRA_FNC_NOTIFICATION;
		};
	}];	
	GFC_CONTROL_BTN_IMPORT ctrlCommit 0;

	GFC_CONTROL_BTN_CLEAR = GFC_DISPLAY ctrlCreate ["RscButtonMenu", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_BTN_CLEAR ctrlSetPosition [safeZoneW * 0.235, safeZoneH * 0.78, safeZoneW * 0.08, safeZoneH * 0.05];
	GFC_CONTROL_BTN_CLEAR ctrlSetStructuredText parseText "<t shadow='2' valign='center' color='#FFFFFF' align='center'>CLEAR</t>";
	GFC_CONTROL_BTN_CLEAR ctrlSetTooltip "Erase the current arsenal array";
	GFC_CONTROL_BTN_CLEAR ctrlAddEventHandler ["ButtonClick", {
		with uiNamespace do {
			GFC_MY_CURRENT_ARSENAL = [];
			[] call GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI;
			[] call GRRA_FNC_DELEGATE_CURRENT_ITEMS_LIST;	
			["Arsenal cleared!", 2] call GRRA_FNC_NOTIFICATION;
		};
	}];
	GFC_CONTROL_BTN_CLEAR ctrlCommit 0;

	GFC_NOTIFICATION_TEXT = GFC_DISPLAY ctrlCreate ["RscText", -1, GFC_CONTROL_GROUP];
	GFC_NOTIFICATION_TEXT ctrlSetPosition [safeZoneW * 0.325, safeZoneH * 0.78, safeZoneW * 0.305, safeZoneH * 0.05];
	GFC_NOTIFICATION_TEXT ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
	GFC_NOTIFICATION_TEXT ctrlSetTextColor GFC_COLOR_WHITE_FULL;
	GFC_NOTIFICATION_TEXT ctrlCommit 0;

	GFC_WEAPON_TYPES = [
		["Rifle",    		[0, 0], "CfgWeapons"],
		["Optic", 			[1, 0], "CfgWeapons"],
		["Rail", 			[1, 1], "CfgWeapons"],
		["Muzzle",         	[1, 2], "CfgWeapons"],
		["Bipod", 			[1, 3], "CfgWeapons"],
		["Pistol",   		[0, 2], "CfgWeapons"],
		["Launcher", 		[0, 1], "CfgWeapons"],
		["Magazines",		2, 		"CfgMagazines"],
		["Headgear", 		3, 		"CfgWeapons"],
		["Uniform",  		4, 		"CfgWeapons"],
		["Vest",     		5, 		"CfgWeapons"],
		["Backpack", 		6, 		"CfgVehicles"],
		["Goggles",  		7, 		"CfgGlasses"],
		["NVG",      		8, 		"CfgWeapons"],
		["Binoculars",      9, 		"CfgWeapons"],
		["Map",      		10, 	"CfgWeapons"],
		["Compass",  		11, 	"CfgWeapons"],
		["Radio",    		12, 	"CfgWeapons"],
		["Watch",    		13, 	"CfgWeapons"],
		["Terminal",    	14, 	"CfgWeapons"],
		["Grenade",    		15, 	"CfgMagazines"],
		["Explosive",      	16, 	"CfgMagazines"],
		["Items",    		17, 	"CfgWeapons"]
	];

	// Column 2: item types scroller
	GFC_CONTROL_LISTBOX_TYPES = GFC_DISPLAY ctrlCreate ["RscControlsGroupNoScrollbars", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_LISTBOX_TYPES ctrlSetPosition [safeZoneW * 0.315, safeZoneH * 0.02, safeZoneW * 0.1, safeZoneH * 0.75];
	GFC_CONTROL_LISTBOX_TYPES ctrlCommit 0;

	{
		private _thisControl = GFC_DISPLAY ctrlCreate ["RscButtonMenu", -1, GFC_CONTROL_LISTBOX_TYPES];
		_thisControl ctrlSetPosition [safeZoneW * 0.0075, _forEachIndex * safeZoneH * 0.05, safeZoneW * 0.1, safeZoneH * 0.0525];// [safeZoneW * 0.325, (safeZoneH * _forEachIndex) * 0.0375, safeZoneW * 0.65, safeZoneH * 0.05];
		_thisControl ctrlSetStructuredText parseText format ["<t shadow='1' size='0.9' color='#FFFFFF' align='left'>%1</t>", _x select 0];
		_thisControl ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
		_typeIndex = _x select 1;
		_items = [];
		if (_typeIndex isEqualType []) then {
			{
				_items pushBack _x;
			} forEach (GFC_ITEMS_ALL#(_typeIndex#0)#(_typeIndex#1));
		} else {
			{
				_items pushBack _x;
			} forEach (GFC_ITEMS_ALL#_typeIndex);
		};		
		_thisControl setVariable ["GFC_TYPE_ITEMS", _items];
		_thisControl setVariable ["GFC_TYPE_CONFIGTYPE", _x select 2];
		_thisControl ctrlAddEventHandler ["ButtonClick", 
		{ 
			params["_ctrl"];
			uiNamespace setVariable ["GFC_CURRENT_CONTROL_TYPE", _ctrl];
			with uiNamespace do 
			{
				private _configPath = GFC_CURRENT_CONTROL_TYPE getVariable "GFC_TYPE_CONFIGTYPE";
				{ctrlDelete _x} forEach GFC_CURRENT_OPTIONS;
				{
					private _thisControl = GFC_DISPLAY ctrlCreate ["RscButtonMenu", -1, GFC_CONTROL_LISTBOX_ITEMS];					
					_thisControl setVariable ["ITEM_CLASS", _x];
					if (_x in GFC_MY_CURRENT_ARSENAL) then {
						_thisControl ctrlSetBackgroundColor GFC_COLOR_WHITE;
						_thisControl ctrlSetTextColor GFC_COLOR_GREEN;
					} else {
						_thisControl ctrlSetBackgroundColor GFC_COLOR_BLACK;
						_thisControl ctrlSetTextColor GFC_COLOR_WHITE_FULL;
					};			
					
					_thisControl ctrlSetPosition [safeZoneW * 0.015, _forEachIndex * safeZoneH * 0.05, safeZoneW * 1.75, safeZoneH * 0.0525];
					_displayText = getText (configfile >> _configPath >> _x >> "displayName");
					_thisControl ctrlSetTooltip _displayText;
					_thisControl ctrlSetStructuredText parseText format ["<img size='1.5' image='%2'/> <t font='PuristaMedium' align='left' size='0.8'>%1</t>", _displayText, getText (configfile >> _configPath >> _x >> "picture")];
					_thisControl ctrlSetFontHeight (safeZoneH * 0.025);
					// ItemClicked ->
					_thisControl ctrlAddEventHandler ["ButtonClick", {
						params["_ctrl"];
						uiNamespace setVariable ["GFC_CURRENT_ITEM_CLICKED", _ctrl];
						with uiNamespace do {
							_ctrl = GFC_CURRENT_ITEM_CLICKED;
							_itemClass = _ctrl getVariable "ITEM_CLASS";
							if (_itemClass in GFC_MY_CURRENT_ARSENAL) then {
								[_itemClass] call GRRA_FNC_ARSENAL_REMOVE;
								_ctrl ctrlSetBackgroundColor GFC_COLOR_BLACK;
								_ctrl ctrlSetTextColor 		 GFC_COLOR_WHITE_FULL;
							} else {
								[_itemClass] call GRRA_FNC_ARSENAL_ADD;
								_ctrl ctrlSetBackgroundColor GFC_COLOR_WHITE;
								_ctrl ctrlSetTextColor 		 GFC_COLOR_GREEN;
							};
							_ctrl ctrlCommit 0;
							[] call GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI;						
						};
					}];
					_thisControl ctrlCommit 0;
					GFC_CURRENT_OPTIONS pushBack _thisControl;
				} forEach (GFC_CURRENT_CONTROL_TYPE getVariable "GFC_TYPE_ITEMS");
				{
					_x ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
					_x ctrlCommit 0;
				} forEach GFC_CURRENT_TYPES;
				GFC_CURRENT_CONTROL_TYPE ctrlSetBackgroundColor GFC_COLOR_WHITE;
			};			
		}]; 
		_thisControl ctrlCommit 0;
		GFC_CURRENT_TYPES pushBack _thisControl;
	} forEach GFC_WEAPON_TYPES;

	// Column 3: items scroller
	GFC_CONTROL_LISTBOX_ITEMS = GFC_DISPLAY ctrlCreate ["RscControlsGroupNoScrollbars", -1, GFC_CONTROL_GROUP];
	GFC_CONTROL_LISTBOX_ITEMS ctrlSetPosition [safeZoneW * 0.4, safeZoneH * 0.02, safeZoneW * 0.2395, safeZoneH * 0.75];
	GFC_CONTROL_LISTBOX_ITEMS ctrlCommit 0;

	/// FUNCTIONS
	GRRA_FNC_NOTIFICATION = {
		GFC_NOTIFICATION_TEXT ctrlSetText _this#0;
		_this spawn {
			sleep (_this#1);
			with uiNamespace do {				
				GFC_NOTIFICATION_TEXT ctrlSetText "";
				GFC_NOTIFICATION_TEXT ctrlCommit 0;
			};	
		};
	};

	GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI = {
		//[GFC_NOTIFICATION_TEXT, ""] call GRRA_FNC_SETTEXT;
		GFC_CONTROL_TEXT_BOX ctrlSetText (str GFC_MY_CURRENT_ARSENAL);
		GFC_CONTROL_TEXT_BOX ctrlCommit 0;
		profileNamespace setVariable ["GFC_MY_CURRENT_ARSENAL", GFC_MY_CURRENT_ARSENAL];
		saveProfileNamespace;	
	};

	GRRA_FNC_ARSENAL_ADD = {
		params["_item"];
		if (_item in GFC_MY_CURRENT_ARSENAL) exitWith {}; 
		GFC_MY_CURRENT_ARSENAL pushBack _item;
	};

	GRRA_FNC_ARSENAL_REMOVE = {
		params["_item"];
		if !(_item in GFC_MY_CURRENT_ARSENAL) exitWith {}; 
		GFC_MY_CURRENT_ARSENAL = GFC_MY_CURRENT_ARSENAL - [_item];
	};

	// Reaccess the items listbox on ui update
	GRRA_FNC_DELEGATE_CURRENT_ITEMS_LIST = {
		with uiNamespace do {
			{
				if ((_x getVariable "ITEM_CLASS") in GFC_MY_CURRENT_ARSENAL) then {
					_x ctrlSetBackgroundColor GFC_COLOR_WHITE;
					_x ctrlSetTextColor 	  GFC_COLOR_GREEN;
				} else {
					_x ctrlSetBackgroundColor GFC_COLOR_BLACK;
					_x ctrlSetTextColor 	  GFC_COLOR_WHITE_FULL;
				};			
				_x ctrlCommit 0;	
			} forEach GFC_CURRENT_OPTIONS;		
		};
	};
	
	// setup UI
	call GRRA_FNC_PARSE_TEXT_BOX_AND_UPDATE_UI;

};

