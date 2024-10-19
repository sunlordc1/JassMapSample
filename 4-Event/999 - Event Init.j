struct REGISTER_EVENT 
    private static method SetupAllEvent takes nothing returns nothing 
        //Comment if u don't use the event 
        call EV_BEGIN_STRUCTION.SetupEvent()
        // ITEM
        call EV_UNIT_ACQUIRES_ITEM.SetupEvent()
        call EV_UNIT_DROP_ITEM.SetupEvent()
        // ORDER
        call EV_TARGET_ORDER.SetupEvent()
        call EV_POINT_ORDER.SetupEvent()
        call EV_NO_TARGET_ORDER.SetupEvent()
        // SPELL
        call EV_CASTING_SPELL.SetupEvent()
        call EV_START_SPELL_EFFECT.SetupEvent()
        call EV_LEARN_SKILL.SetupEvent()
        // MISC
        call EV_UNIT_DEATH.SetupEvent()
        call EV_UNIT_ATTACK.SetupEvent()
        call EV_UNIT_SELL.SetupEvent()
        call DestroyTimer(GetExpiredTimer()) 
    endmethod
    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), TIME_SETUP_EVENT, false, function thistype.SetupAllEvent) 
    endmethod 
endstruct 
