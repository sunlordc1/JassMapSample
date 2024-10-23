struct Interval 
    static integer times = 0 
    static method tick takes nothing returns nothing 

        //Comment if not use   
        call MULTILBOARD_EXAMPLE.update() 

        if ModuloInteger(.times, 5) == 0 then 
            call ROADLINE_EXAMPLE.summon() 
        endif 
        set.times =.times + 1 
        call ROADLINE_EXAMPLE.order()
      
    endmethod 
    static method start takes nothing returns nothing 
        call TimerStart(CreateTimer(), TIME_INTERVAL, true, function thistype.tick) 
    endmethod 
endstruct