struct EV_NO_TARGET_ORDER 
    static method Checking takes nothing returns nothing 
        local unit u = GetTriggerUnit() 
          
        set u = null 
    endmethod 
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_ORDER) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 

