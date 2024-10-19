
struct EV_UNIT_SELL 
    static method f_Checking takes nothing returns boolean 
        local unit u = GetSoldUnit() 
        local unit caster = GetTriggerUnit() 
        local integer pid = GetPlayerId(GetOwningPlayer(GetSoldUnit())) 

        set u = null 
        set caster = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SELL) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 
