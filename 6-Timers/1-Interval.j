struct Interval 
    static integer times = 0 
    static method tick takes nothing returns nothing 
        call MULTILBOARD_EXAMPLE.update()
        set.times =.times + 1 
    endmethod 
    static method start takes nothing returns nothing 
        call TimerStart(CreateTimer(), TIME_INTERVAL, true, function thistype.tick) 
    endmethod 
endstruct