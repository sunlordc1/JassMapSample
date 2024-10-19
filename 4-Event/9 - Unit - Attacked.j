


struct EV_UNIT_ATTACK
    static method f_Checking takes nothing returns boolean 
        local unit attacker = GetAttacker() 
        local unit attacked = GetTriggerUnit() 
        //Trick: Someone use it for stop attack to ally



        set attacker = null 
        set attacked = null 
        return false 
    endmethod 
 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct