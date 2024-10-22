

struct GAME 
    static boolean IsSinglePlay = false 
    static integer CountPlayer = 0 

    static Multiboard MB 
    private static method GameStart takes nothing returns nothing 
        local framehandle test1 = null 
        call FogMaskEnable(false) 
        call FogEnable(true) 

        // call PauseGame(false)              
        call CinematicModeBJ(false, GetPlayersAll()) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Game Start ...") 
        endif 
        // COUNTDOWN TIMER EXAMPLE  If not use then delete this 
        call COUNTDOWN_TIMER_EXAMPLE.start()
        call MULTILBOARD_EXAMPLE.start()
        //
        call Interval.start()
    endmethod 

    private static method GameSetting takes nothing returns nothing 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Setting Game ...") 
        endif 
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, LOCK_RESOURCE_TRADING) 
        call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, SHARED_ADVANCED_CONTROL) 
        call EnableCreepSleepBJ(CREEP_SLEEP) 

 

        call DestroyTimer(GetExpiredTimer()) 
      
    endmethod 
    private static method GameStatus takes nothing returns nothing 
        local integer n = 0 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Checking Status ...") 
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
        call FogEnable(false) 
        // call PauseGame(true)              
        call CinematicModeBJ(true, GetPlayersAll()) 
        call PanCameraToTimed(0, 0, 0) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Preload ...") 
        endif 
        //For setup framhandle setting, if u not use my code UI then delete it     
        call Frame.init() 
        //From to: https://www.hiveworkshop.com/threads/ui-showing-3-multiboards.316610/     
        //Will add more multilboard     
        call BlzLoadTOCFile("war3mapImported\\multiboard.toc") 
        call Preload_Ability('Amls') // Preload skill                                  
        call Preload_Unit('uloc') // Preload unit                                 
        call Preload_Unit('e000') // Preload dummy                                 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), GAME_PRELOAD_TIME, false, function thistype.PreloadMap) 
        call TimerStart(CreateTimer(), GAME_STATUS_TIME, false, function thistype.GameStatus) 
        call TimerStart(CreateTimer(), GAME_SETTING_TIME, false, function thistype.GameSetting) 
        call TimerStart(CreateTimer(), GAME_START_TIME, false, function thistype.GameStart) 
    endmethod 
endstruct 
