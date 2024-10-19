struct EVENT_PLAYER_LEAVES 
    static method Checking takes nothing returns boolean 
        local player p = GetTriggerPlayer() 
        set PLAYER.IsDisconect[GetPID(p)] = true 


        set p = null 
        return false 
    endmethod 
    private static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() // Create a trigger                                                                                                                          
        local integer n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            call TriggerRegisterPlayerEventLeave(t, Player(n)) 
            set n = n + 1 
        endloop 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 