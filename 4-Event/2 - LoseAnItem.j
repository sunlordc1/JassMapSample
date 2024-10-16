struct EVENT_UNIT_DROP_ITEM 
    static method Checking takes nothing returns boolean 
        local unit caster = GetTriggerUnit() 
        local integer itcode = GetItemTypeId(GetManipulatedItem()) 
        local item dropitem = GetManipulatedItem() 
        local integer pid = GetPlayerId(GetTriggerPlayer()) 
        local integer charge = GetItemCharges(dropitem) 

        set dropitem = null 
        set caster = null 
        return false 
    endmethod 
    private static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 

endstruct