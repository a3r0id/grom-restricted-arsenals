class CfgFunctions
{
    class GRRA
    {
        class Functions
        {
            file = GRRA_FUNCTIONS_DIR;        
            tag  = "GRRA"; 
            class initPlayer                {postInit = 1;};    // GRRA_fnc_initPlayer
            class cleanArsenalBox           {};                 // GRRA_fnc_cleanArsenalBox
            class rolesMatch                {};                 // GRRA_fnc_rolesMatch
            class sidesMatch                {};                 // GRRA_fnc_sidesMatch
            class strToArray                {};                 // GRRA_fnc_strToArray
            class fileStringToArray         {};                 // GRRA_fnc_fileStringToArray
            class addItemsVanillaArsenal    {};                 // GRRA_fnc_addItemsVanillaArsenal
            class aceGetAllCfgItems         {};                 // GRRA_fnc_aceGetAllCfgItems
            class formatter                 {};                 // GRRA_fnc_formatter
        };
    };
};