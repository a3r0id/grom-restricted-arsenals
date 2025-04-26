#include "CfgFunctions.hpp"
#define GRRA_MOD_DESCRIPTION 3 DEN module that allows creators to initialize an infinite amount of ACE arsenals restricted by player role and other attributes.
#define GRRA_MOD_LOGO grra\data\grra.paa
#define GRRA_MOD_ICON grra\data\grra_icon.paa
#define GRRA_MOD_AUTHOR Grom
#define GRRA_MOD_NAME Grom Restricted Arsenals

class CfgPatches {
	class GRRA {
		name = GRRA_MOD_NAME;
		author = GRRA_MOD_AUTHOR;
		logo = GRRA_MOD_LOGO;
		logoOver = GRRA_MOD_LOGO;
		tooltip = GRRA_MOD_DESCRIPTION;
		tooltipOwned = GRRA_MOD_DESCRIPTION;
		picture = GRRA_MOD_LOGO;
		url = "https://github.com/a3r0id";
		units[] = {
			"GRRA_ModuleRoleRestrictedArsenal",
			"GRRA_ModuleBaseArsenal",
			"GRRA_AceArsenalOverride"
		};
		requiredVersion = 1.0;
		requiredAddons[] = {
			"A3_Modules_F",
			"3DEN"
		};
	};
};

// Base Side Component Class
class Side: Combo {
	property = "<default>";
	displayName = "Side";
	tooltip = "<default>";
	typeName = "NUMBER";
	defaultValue = "0";

	class Values {
		class opt0 {
			name = "ALL";
			value = 0;
		};
		class opt1 {
			name = "BLUFOR";
			value = 1;
		};
		class opt2 {
			name = "OPFOR";
			value = 2;
		};
		class opt3 {
			name = "INDEPENDENT";
			value = 3;
		};
		class opt4 {
			name = "CIVILIAN";
			value = 4;
		};
	};
};

class CfgFactionClasses {
	class NO_CATEGORY;
	class GRRA_Modules: NO_CATEGORY {
		displayName = GRRA_MOD_NAME;
	};
};

class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};

		class ModuleDescription {
			class AnyBrain;
		};
	};

	class GRRA_ModuleRoleRestrictedArsenal: Module_F {
		scope = 2;
		displayName = "Restricted Arsenal";
		icon = GRRA_MOD_ICON;
		category = "GRRA_Modules";
		function = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 1;
		isDisposable = 1;
		is3DEN = 1;
		curatorInfoType = "";

		class Attributes: AttributesBase {
			
			// Extend the base attributes
			class Side: Side {
				property = "GRRA_ModuleRoleRestrictedArsenal_Side"; // Unique property (use "<GRRA>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
				tooltip = "Side that the base arsenal is for."; // Tooltip description
			};

			class Owner: Edit {
				property = "GRRA_ModuleRoleRestrictedArsenal_Owner";
				displayName = "Owner";
				tooltip = "Variable or classname of the arsenal object.";
				defaultValue = """""";
			};

			class Role: Edit {
				property = "GRRA_ModuleRoleRestrictedArsenal_Role";
				displayName = "Role";
				tooltip = "Role substring of the unit/s that can use the arsenal.";
				defaultValue = """""";
			};

			class Group: Edit {
				property = "GRRA_ModuleRoleRestrictedArsenal_Group";
				displayName = "Group";
				tooltip = "Group substring of the unit/s that can use the arsenal.";
				defaultValue = """""";
			};			

			class Player: Edit {
				property = "GRRA_ModuleRoleRestrictedArsenal_Player";
				displayName = "Player";
				tooltip = "Steam64ID of player that can use the arsenal. This will override the Role/Side attributes.";
				defaultValue = """""";
			}

			class Items: Edit {
				property = "GRRA_ModuleRoleRestrictedArsenal_Items";
				displayName = "Items";
				tooltip = "Array/comma-seperated values of items that the unit/s can use. Also accepts file/s; IE: 'file://path\to\file.sqf' or 'file://path\to\file.sqf//path\to\file2.sqf'.";
				defaultValue = """[]""";
			};
		};
	};

	class GRRA_ModuleBaseArsenal: Module_F {
		scope = 2;
		displayName = "Base Arsenal";
		icon = GRRA_MOD_ICON;
		category = "GRRA_Modules";
		function = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 1;
		isDisposable = 1;
		is3DEN = 1;
		curatorInfoType = "";

		class Attributes: AttributesBase {

			// fart
			class Side: Side {
				property = "GRRA_ModuleBaseArsenal_Side";
				tooltip = "Side that can use the arsenal.";
			}

			class Owner: Edit {
				property = "GRRA_ModuleBaseArsenal_Owner";
				displayName = "Owner";
				tooltip = "Variable or classname of the arsenal object.";
				defaultValue = """""";
			};

			class Items: Edit {
				property = "GRRA_ModuleBaseArsenal_Items";
				displayName = "Items";
				tooltip = "Array/comma-seperated values of items that the unit/s can use. Also accepts file/s; IE: 'file://path\to\file.sqf' or 'file://path\to\file.sqf//path\to\file2.sqf'.";
				defaultValue = """[]""";
			};
		};
	};

	class GRRA_AceArsenalOverride: Module_F {
		scope = 2;
		displayName = "Force Vanilla Arsenal";
		icon = GRRA_MOD_ICON;
		category = "GRRA_Modules";
		function = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 1;
		isDisposable = 1;
		is3DEN = 1;
		curatorInfoType = "";
		class Attributes: AttributesBase {};
	};
};