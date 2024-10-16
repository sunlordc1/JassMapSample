struct EVENT_BEGIN_STRUCTION
    static method Checking takes nothing returns boolean 
        local unit builder = GetTriggerUnit() 
        local unit structuring = GetConstructingStructure() 
        local integer sid = GetUnitTypeId(structuring) 
        local integer pid = GetPlayerId(GetOwningPlayer(structuring)) 


        // commonly used sample trick : Cancel a build under construction with conditions
        if false then //Make your condition
            call TriggerSleepAction( 0.01 ) //need for the trick
            call IssueImmediateOrderById(structuring, 851976) //order cancel build
        endif
        //===============================================================================

        set builder = null 
        set structuring = null 
        return false 
    endmethod 
    private static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger()                    
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_CONSTRUCT_START) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 
