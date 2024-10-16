struct REGISTER_EVENT 
    private static method onInit takes nothing returns nothing 
        //Comment if u don't use the event 
        call TimerStart(CreateTimer(), TIME_SETUP_EVENT, false, function EVENT_BEGIN_STRUCTION.SetupEvent) 
    endmethod 
endstruct 
