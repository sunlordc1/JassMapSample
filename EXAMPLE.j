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


struct QUEST_EXAMPLE 
    static Quest Kill_SkeletonQuest 
    static Questitem Kill_SkeletonArcher 
    static integer archer_id = 'nska' 
    static integer archer = 0 
    static integer max_archer = 3 
    static Questitem Kill_SkeletonWarrior 
    static integer warrior_id = 'nskg' 
    static integer warrior = 0 
    static integer max_warrior = 3 
    static method kill_archer takes nothing returns nothing 
        local string str = "" 
        if.Kill_SkeletonArcher.completed() == false then 
            set.archer =.archer + 1 
            set.archer = IMinBJ(.archer,.max_archer) 
            set str = "Kill Skeleton Archer: " + I2S(.archer) + "/" + I2S(.max_archer) 
            call.Kill_SkeletonArcher.desc(str) 
            if.archer ==.max_archer then 
                call.Kill_SkeletonArcher.setcompleted(true) 
                call PLAYER.questmsgforce(GetPlayersAll(), str, Questmsg.COMPLETED) 
            endif 
            call.update() 
        endif 
    endmethod 
    static method kill_warrior takes nothing returns nothing 
        local string str = "" 
        if.Kill_SkeletonWarrior.completed() == false then 
            set.warrior =.warrior + 1 
            set.warrior = IMinBJ(.warrior,.max_warrior) 
            set str = "Kill Giant Skeleton Warrior: " + I2S(.warrior) + "/" + I2S(.max_warrior) 
            call.Kill_SkeletonWarrior.desc(str) 
            if.warrior ==.max_warrior then 
                call.Kill_SkeletonWarrior.setcompleted(true) 
                call PLAYER.questmsgforce(GetPlayersAll(), str, Questmsg.COMPLETED) 
            endif 
            call.update() 
        endif 
    endmethod 
    static method update takes nothing returns nothing 
        local string str = "" 
        if.Kill_SkeletonQuest != null and.Kill_SkeletonQuest.completed() == false then 
            if.Kill_SkeletonArcher.completed() == true and.Kill_SkeletonWarrior.completed() == true then 
                call.Kill_SkeletonQuest.setcompleted(true) 
                call.Kill_SkeletonQuest.desc("[Complete] Deafeat Skeleton in Forest ") 
                call PLAYER.questmsgforce(GetPlayersAll(), "Deafeat Skeleton in Forest", Questmsg.COMPLETED) 
            endif 
        endif 
    endmethod 
    static method start takes nothing returns nothing 
        local string str = "" 
        set.Kill_SkeletonQuest = Quest.create() 
        set str = "Deafeat Skeleton in Forest" 
        call.Kill_SkeletonQuest.new(Questtype.REQ_DISCOVERED, "Kill Skeleton", str, "ReplaceableTextures\\CommandButtons\\BTNSkeletonWarrior.tga") 
        
        set.Kill_SkeletonArcher = Questitem.create() 
        set str = "Kill Skeleton Archer: " + I2S(.archer) + "/" + I2S(.max_archer) 
        call.Kill_SkeletonArcher.new(.Kill_SkeletonQuest.q, str) 

        set.Kill_SkeletonWarrior = Questitem.create() 
        set str = "Kill Giant Skeleton Warrior: " + I2S(.warrior) + "/" + I2S(.max_warrior) 
        call.Kill_SkeletonWarrior.new(.Kill_SkeletonQuest.q, str) 
    endmethod 
endstruct 

struct ROADLINE_EXAMPLE 
    static integer Move = 851986 
    static integer Almove = 851988 
    static integer Attack = 851983 
    static method io takes unit u, integer order returns boolean 
        return GetUnitCurrentOrder(u) == order // Returns true or false when comparing the input order id value with the current unit's order value                                                                                                     
    endmethod 
    static method IsNotAction takes unit u returns boolean 
        return not(.io(u,.Move) or.io(u,.Almove) or.io(u,.Attack)) 
    endmethod 
    static method summon takes nothing returns nothing 
        local integer roll = GetRandomInt(0, 2) 
        if roll == 2 then 
            set bj_unit = CreateUnit(Player(10), 'hpea', GetRectCenterX(gg_rct_r1), GetRectCenterY(gg_rct_r1), 0) 
            call Roadline.register(bj_unit, gg_rct_r1, "road1") 
        elseif roll == 1 then 
            set bj_unit = CreateUnit(Player(10), 'hpea', GetRectCenterX(gg_rct_r3), GetRectCenterY(gg_rct_r3), 0) 
            call Roadline.register(bj_unit, gg_rct_r3, "road2") 
        else 
            set bj_unit = CreateUnit(Player(10), 'hpea', GetRectCenterX(gg_rct_r4), GetRectCenterY(gg_rct_r4), 0) 
            call Roadline.register(bj_unit, gg_rct_r4, "road3") 
        endif 
        call SetUnitPathing(bj_unit, false) 

    endmethod 
    static method start takes nothing returns nothing 
        // new ( your_region_now, your_region_come, your_delay , your_road_name , new_road, teleport?) 
        call Roadline.new(gg_rct_r1, gg_rct_r2, 3, "road1", "", false) 
        call Roadline.new(gg_rct_r2, gg_rct_r3, 3, "road1", "", false) 
        
        call Roadline.new(gg_rct_r3, gg_rct_r2, 3, "road1", "road2", false) 
        //=>   
        call Roadline.new(gg_rct_r3, gg_rct_r2, 3, "road2", "", false) 
        call Roadline.new(gg_rct_r2, gg_rct_r1, 3, "road2", "road1", false) 

        call Roadline.new(gg_rct_r4, gg_rct_r5, 3, "road3", "", true) 
        call Roadline.new(gg_rct_r5, gg_rct_r4, 3, "road3", "", true) 

    endmethod 
    static method order takes nothing returns nothing 
        local unit e = null 
        local group g = null 
        local integer id = -1 
        set g = CreateGroup() 
        call Group.enump(g, Player(10)) 
        loop 
            set e = FirstOfGroup(g) 
            exitwhen e == null 
            set id = GetHandleId(e) 
            if GetUnitState(e, UNIT_STATE_LIFE) > 0 and IsUnitType(e, UNIT_TYPE_STRUCTURE) == false and.IsNotAction(e) then 
                if Roadline.LoadRoad(id) != "" then 
                    if Roadline.LoadDelay(id) > 0 then 
                        call Roadline.SaveDelay(id, Roadline.LoadDelay(id) -1) 
                    else 
                        // call BJDebugMsg(R2S(Roadline.LoadX(id)) + " [] " + R2S(Roadline.LoadY(id)))            
                        if Roadline.IsTele(id) then 
                            call SetUnitPosition(e, Roadline.LoadX(id), Roadline.LoadY(id)) 
                            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", Roadline.LoadX(id), Roadline.LoadY(id))) 
                        else 
                            //Change it to "move" or "attack" if attack is target then contact me for more custom       
                            call IssuePointOrder(e, "move", Roadline.LoadX(id), Roadline.LoadY(id)) 
                        endif 
                    endif 
                endif 
            endif 
            call Group.remove(e, g) 
        endloop 
        call Group.release(g) 
        set e = null 
    endmethod 
endstruct