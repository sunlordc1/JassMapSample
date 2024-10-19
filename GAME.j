struct GAME 
    static boolean IsSinglePlay = false 
    static integer CountPlayer = 0 
    private static method GameStart takes nothing returns nothing 
        call FogMaskEnable(false) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Game Start ...")
        endif 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method GameSetting takes nothing returns nothing 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Setting Game ...")
        endif 
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, LOCK_RESOURCE_TRADING) 
        call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, SHARED_ADVANCED_CONTROL) 
        call EnableCreepSleepBJ(CREEP_SLEEP) 

 

        call DestroyTimer(GetExpiredTimer()) 
      
    endmethod 
    private static method GameStatus takes nothing returns nothing 
        local integer n = 0 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Checking Status ...")
        endif 
        // Check player is online in game  
        set n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            if PLAYER.IsPlayerOnline(Player(n)) then 
                set PLAYER.IsDisconect[n] = false 
                set GAME.CountPlayer = GAME.CountPlayer + 1 
            else 
                set PLAYER.IsDisconect[n] = true 
            endif 
            set n = n + 1 
        endloop 
        call DestroyTimer(GetExpiredTimer()) 
         
    endmethod 
    private static method PreloadMap takes nothing returns nothing 
        call FogMaskEnable(true) 
        call PanCameraToTimed(0, 0, 0) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Preload ...")
        endif 
       
        call Preload_Ability('Amls') // Preload skill               
        call Preload_Unit('uloc') // Preload unit              
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), GAME_PRELOAD_TIME, false, function thistype.PreloadMap) 
        call TimerStart(CreateTimer(), GAME_STATUS_TIME, false, function thistype.GameStatus) 
        call TimerStart(CreateTimer(), GAME_SETTING_TIME, false, function thistype.GameSetting) 
        call TimerStart(CreateTimer(), GAME_START_TIME, false, function thistype.GameStart) 
    endmethod 
endstruct 
