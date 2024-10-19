struct GAME 
    static boolean IsSinglePlay = false 

    private static method GameStart takes nothing returns nothing 
        
    endmethod 

    private static method GameSetting takes nothing returns nothing 
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, LOCK_RESOURCE_TRADING) 
        call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, SHARED_ADVANCED_CONTROL) 
        call EnableCreepSleepBJ(CREEP_SLEEP) 

      
    endmethod 
    private static method PreloadMap takes nothing returns nothing 
        call Preload_Ability('Amls') // Preload skill          
        call Preload_Unit('uloc') // Preload unit          
    endmethod 

    private static method onInit takes nothing returns nothing 

    endmethod 
endstruct 
