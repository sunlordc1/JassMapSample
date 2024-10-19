struct REGISTER_EVENT 
    private static method SetupAllEvent takes nothing returns nothing 
        //Comment if u don't use the event 
        call EVENT_BEGIN_STRUCTION.SetupEvent()
        // ITEM
        call EVENT_UNIT_ACQUIRES_ITEM.SetupEvent()
        call EVENT_UNIT_DROP_ITEM.SetupEvent()
        // ORDER
        call EVENT_TARGET_ORDER.SetupEvent()
        call EVENT_POINT_ORDER.SetupEvent()
        call EVENT_NO_TARGET_ORDER.SetupEvent()
        // SPELL
        call EVENT_CASTING_SPELL.SetupEvent()
        call EVENT_START_SPELL_EFFECT.SetupEvent()
        call EVENT_LEARN_SKILL.SetupEvent()
        // MISC
        call EVENT_UNIT_DEATH.SetupEvent()
        call EVENT_UNIT_ATTACK.SetupEvent()
        call EVENT_UNIT_SELL.SetupEvent()
        call DestroyTimer(GetExpiredTimer()) 
    endmethod
    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), TIME_SETUP_EVENT, false, function thistype.SetupAllEvent) 
    endmethod 
endstruct 
