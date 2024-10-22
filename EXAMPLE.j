// COUNTDOWN TIMER EXAMPLE  If not use then delete this                                                  
struct COUNTDOWN_TIMER_EXAMPLE 
    static CountdownTimer StartEvent 
    static integer TimesStartEvent = 0 
    static method start takes nothing returns nothing 
        set COUNTDOWN_TIMER_EXAMPLE.StartEvent = CountdownTimer.create() 
        call COUNTDOWN_TIMER_EXAMPLE.StartEvent.newdialog("10 secs event", 10, true, function thistype.tensec) 
    endmethod 
    private static method tensec takes nothing returns nothing 
        set COUNTDOWN_TIMER_EXAMPLE.TimesStartEvent = COUNTDOWN_TIMER_EXAMPLE.TimesStartEvent + 1 
        if ENV_DEV then 
            call BJDebugMsg("Times:" + I2S(COUNTDOWN_TIMER_EXAMPLE.TimesStartEvent)) 
        endif 
        if COUNTDOWN_TIMER_EXAMPLE.TimesStartEvent == 1 then 
            call COUNTDOWN_TIMER_EXAMPLE.StartEvent.title("Last time") 
            call COUNTDOWN_TIMER_EXAMPLE.StartEvent.titlecolor(255, 0, 0, 255) 
            call COUNTDOWN_TIMER_EXAMPLE.StartEvent.timercolor(255, 0, 0, 255) 
        endif 
        if COUNTDOWN_TIMER_EXAMPLE.TimesStartEvent == 2 then 
            call COUNTDOWN_TIMER_EXAMPLE.StartEvent.destroytd() 
            call COUNTDOWN_TIMER_EXAMPLE.StartEvent.destroy() 
        endif 
    endmethod 
endstruct 

struct MULTILBOARD_EXAMPLE 
    static Multiboard MB 
    static integer max_row = 1 
    static string array hero_path 
    static method setindex takes integer pid returns nothing 
        call SaveInteger(ht, 0x63746264, GetHandleId(Player(pid)),.max_row) 
        if ENV_DEV then 
            call BJDebugMsg("Multiboard[]" + I2S(pid) + "[]" + I2S(.max_row)) 
        endif 
    endmethod 
    static method I2Row takes integer pid returns integer 
        local integer r = LoadInteger(ht, 0x63746264, GetHandleId(Player(pid))) 
        return r 
    endmethod 
    static method start takes nothing returns nothing 
        set MULTILBOARD_EXAMPLE.MB = Multiboard.create() 
        //                                   
        set bj_int = bj_MAX_PLAYER_SLOTS 
        loop 
            set bj_int = bj_int - 1 
            set.hero_path[bj_int - 1] = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp" 
            if(GetPlayerController(Player(bj_int - 1)) == MAP_CONTROL_USER) and(GetPlayerSlotState(Player(bj_int - 1)) == PLAYER_SLOT_STATE_PLAYING) then 
                call.setindex(.max_row) 
                set.max_row =.max_row + 1 
            endif 
            exitwhen bj_int == 1 
        endloop 
        call MULTILBOARD_EXAMPLE.MB.new(.max_row - 1, 4, "Multiboard") 

        call.setup() 
        call MULTILBOARD_EXAMPLE.MB.minimize(false) 
    endmethod 
    static method setup takes nothing returns nothing 
        set bj_int = bj_MAX_PLAYER_SLOTS - 1 
        loop 
            set bj_int = bj_int - 1 
            if I2Row(bj_int + 1) > 0 then 
                call MULTILBOARD_EXAMPLE.MB.setstyle(1,.I2Row(bj_int + 1), true, true) 
                call MULTILBOARD_EXAMPLE.MB.setvalue(1,.I2Row(bj_int + 1), GetPlayerName(Player(bj_int))) 
                call MULTILBOARD_EXAMPLE.MB.seticon(1,.I2Row(bj_int + 1),.hero_path[bj_int]) 
                call MULTILBOARD_EXAMPLE.MB.setwidth(1,.I2Row(bj_int + 1), 8) 
                
                call MULTILBOARD_EXAMPLE.MB.setstyle(2,.I2Row(bj_int + 1), true, true) 
                call MULTILBOARD_EXAMPLE.MB.setvalue(2,.I2Row(bj_int + 1), I2S(PLAYER.gold(bj_int))) 
                call MULTILBOARD_EXAMPLE.MB.seticon(2,.I2Row(bj_int + 1), "UI\\Feedback\\Resources\\ResourceGold.blp") 
                call MULTILBOARD_EXAMPLE.MB.setwidth(2,.I2Row(bj_int + 1), 8) 
            
                call MULTILBOARD_EXAMPLE.MB.setstyle(3,.I2Row(bj_int + 1), true, true) 
                call MULTILBOARD_EXAMPLE.MB.setvalue(3,.I2Row(bj_int + 1), I2S(PLAYER.lumber(bj_int))) 
                call MULTILBOARD_EXAMPLE.MB.seticon(3,.I2Row(bj_int + 1), "UI\\Feedback\\Resources\\ResourceLumber.blp") 
                call MULTILBOARD_EXAMPLE.MB.setwidth(3,.I2Row(bj_int + 1), 8) 

                call MULTILBOARD_EXAMPLE.MB.setstyle(4,.I2Row(bj_int + 1), true, true) 
                call MULTILBOARD_EXAMPLE.MB.setvalue(4,.I2Row(bj_int + 1), I2S(PLAYER.food(bj_int)) + "/" + I2S(PLAYER.foodcap(bj_int))) 
                call MULTILBOARD_EXAMPLE.MB.seticon(4,.I2Row(bj_int + 1), "UI\\Feedback\\Resources\\ResourceSupply.blp") 
                call MULTILBOARD_EXAMPLE.MB.setwidth(4,.I2Row(bj_int + 1), 8) 
            endif 
            exitwhen bj_int == 0 
        endloop 
    endmethod 
    static method update takes nothing returns nothing 
        set bj_int = 0 
        loop 
            exitwhen bj_int > bj_MAX_PLAYER_SLOTS - 1 
            if I2Row(bj_int + 1) > 0 then 
                // call MULTILBOARD_EXAMPLE.MB.setvalue(1,.I2Row(bj_int), GetPlayerName(Player(bj_int)))     
                call MULTILBOARD_EXAMPLE.MB.seticon(1,.I2Row(bj_int + 1),.hero_path[bj_int]) 
                
                call MULTILBOARD_EXAMPLE.MB.setvalue(2,.I2Row(bj_int + 1), I2S(PLAYER.gold(bj_int))) 
            
                call MULTILBOARD_EXAMPLE.MB.setvalue(3,.I2Row(bj_int + 1), I2S(PLAYER.lumber(bj_int))) 

                call MULTILBOARD_EXAMPLE.MB.setvalue(4,.I2Row(bj_int + 1), I2S(PLAYER.food(bj_int)) + "/" + I2S(PLAYER.foodcap(bj_int))) 
            endif 
            set bj_int = bj_int + 1 
        endloop 
    endmethod 
endstruct