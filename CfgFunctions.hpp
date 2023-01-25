
#ifdef GRRA_DEBUG
    // running from mission folder
    #define GRRA_FUNCTIONS_DIR functions
#else
    // running as mod
    #define GRRA_FUNCTIONS_DIR \GRRA\functions
#endif


class CfgFunctions
{
    class GRRA
    {
        class Functions
        {
            file = GRRA_FUNCTIONS_DIR;        
            tag  = "GRRA"; 
            class initPlayer       {postInit = 1;}; // GRRA_fnc_initPlayer
            class cleanArsenalBox  {};              // GRRA_fnc_cleanArsenalBox
            class rolesMatch       {};              // GRRA_fnc_rolesMatch
            class sidesMatch       {};              // GRRA_fnc_sidesMatch
            class strToArray       {};              // GRRA_fnc_strToArray
        };
    };
};