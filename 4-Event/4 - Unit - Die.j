

struct EV_UNIT_DEATH 
    static method f_Checking takes nothing returns boolean 
        local unit killer = GetKillingUnit() 
        local unit dying = GetDyingUnit() 
        local integer hdid = GetHandleId(dying) 
        local integer hkid = GetHandleId(killer) 
        local integer did = GetUnitTypeId(dying) 
        local integer kid = GetUnitTypeId(killer) 
        local integer pdid = Num.uid(dying) //Id player of dying  
        local integer pkid = Num.uid(killer) //Id player of killer  



        set killer = null 
        set dying = null 
        return false 
    endmethod 
 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct