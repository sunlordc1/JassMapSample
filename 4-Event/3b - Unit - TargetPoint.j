struct EV_POINT_ORDER 
    static method Checking takes nothing returns nothing 
        local unit u = GetTriggerUnit() 
        local real x = GetOrderPointX() 
        local real y = GetOrderPointY() 

   
          
        set u = null 
    endmethod 
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 

