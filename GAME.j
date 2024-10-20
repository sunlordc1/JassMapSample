struct GAME 
    static boolean IsSinglePlay = false 
    static integer CountPlayer = 0 
    private static method GameStart takes nothing returns nothing 
        local framehandle test1 = null 
        call FogMaskEnable(false) 
        call FogEnable(true)

        // call PauseGame(false) 
        call CinematicModeBJ(false, GetPlayersAll()) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Game Start ...") 
        endif 
        // set test1 = Frame.button("war3mapImported\\tooltipBG.blp")  
        // call Frame.hide(test1)  
        // call Frame.showx(0, test1)  
        // call Frame.movex(test1, 0.16304, 0.29219, 0.12194, 0.21301)  
        // call Frame.click(test1, function thistype.ClickTest1)  
        // call DestroyTimer(GetExpiredTimer())  
    endmethod 
    // private static method ClickTest1 takes nothing returns nothing  
    //     local player p = GetTriggerPlayer()  
    //     local integer id = GetPlayerId(GetTriggerPlayer())  
    //     local framehandle f = BlzGetTriggerFrame()  
    //     if f != null then  
    //         call PLAYER.systemchat(Player(id), "Select 1")  
    //         call Frame.hidex(id, f)  
    //         call Frame.fixed(id)  
    //     endif  
    //     set p = null  
    //     set f = null  
    // endmethod  
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
        call Frame.init() 
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
