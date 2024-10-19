struct EV_BEGIN_STRUCTION 
    static method f_Checking takes nothing returns boolean 
        local unit builder = GetTriggerUnit() 
        local unit constructing = GetConstructingStructure() 
        local integer sid = GetUnitTypeId(constructing) 
        local integer pid = GetPlayerId(GetOwningPlayer(constructing)) 


        // commonly used sample trick : Cancel a build under construction with conditions  
        if sid == '0000' and false then //Make your condition  
            call TriggerSleepAction(0.01) //need for the trick  
            call IssueImmediateOrderById(constructing, 851976) //order cancel build  
            return false 
        endif 
        //===============================================================================  

        set builder = null 
        set constructing = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_CONSTRUCT_START) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 
