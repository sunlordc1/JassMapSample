struct GAME 
    static boolean IsSinglePlay = false 
    static integer CountPlayer = 0 
    static CountdownTimer StartEvent 
    static integer TimesStartEvent = 0 
    private static method GameStart takes nothing returns nothing 
        local framehandle test1 = null 
        call FogMaskEnable(false) 
        call FogEnable(true) 

        // call PauseGame(false)         
        call CinematicModeBJ(false, GetPlayersAll()) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(), "Game Start ...") 
        endif 

        set GAME.StartEvent = CountdownTimer.create() 
        call GAME.StartEvent.newdialog("10 secs event", 10, true, function thistype.tensec) 
        call GAME.StartEvent.title("10 secs event") 
    endmethod 
    private static method tensec takes nothing returns nothing 
        set GAME.TimesStartEvent = GAME.TimesStartEvent + 1 
        if ENV_DEV then 
            call BJDebugMsg("Times:" + I2S(GAME.TimesStartEvent)) 
        endif 
        if GAME.TimesStartEvent == 1 then 
            call GAME.StartEvent.titlecolor(255, 0, 0, 255) 
            call GAME.StartEvent.timercolor(255, 0, 0, 255) 
        endif 
        if GAME.TimesStartEvent == 2 then 
            call GAME.StartEvent.destroytd() 
        endif 
      
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
