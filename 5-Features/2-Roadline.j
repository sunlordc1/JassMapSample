globals 
    hashtable road = InitHashtable() // For damage system                                                        
    constant integer MAX_SIZE_ROADLINE = 99 //Max size you use for a region save a point with name difference           
endglobals 

struct Region 
    trigger t 
    rect r 
    region rg 
    string array name[MAX_SIZE_ROADLINE] 
    real array x[MAX_SIZE_ROADLINE] 
    real array y[MAX_SIZE_ROADLINE] 
    integer array delay[MAX_SIZE_ROADLINE] 
    integer size = -1 
    string array new_road[MAX_SIZE_ROADLINE] 
    boolean array is_teleport[MAX_SIZE_ROADLINE] 
    method name2id takes string name returns integer 
        local integer r = -1 
        local integer n = 0 
        loop 
            exitwhen n >.size 
            if.name[n] == name then 
                set r = n 
                exitwhen true 
            endif 
            set n = n + 1 
            
        endloop 
        return r 
    endmethod 
endstruct 
struct Roadline 
    static integer i = -1 
    static Region array regions 
    static integer ROAD = StringHash("road") 
    static integer DELAY = StringHash("delay") 
    static integer X = StringHash("x") 
    static integer Y = StringHash("y") 
    static integer IS_TELE = StringHash("tele") 

    static method LoadRoad takes integer hid returns string 
        local string r = "" 
        set r = LoadStr(road, hid, Roadline.ROAD) 
        return r 
    endmethod 
    
    static method SaveDelay takes integer hid, integer delaytime returns nothing 
        call SaveInteger(road, hid, Roadline.DELAY, delaytime) 
    endmethod 
    static method LoadDelay takes integer hid returns integer 
        local integer r = 0 
        set r = LoadInteger(road, hid, Roadline.DELAY) 
        return r 
    endmethod 
    static method IsTele takes integer hid returns boolean 
        local boolean r = false 
        set r = LoadBoolean(road, hid, Roadline.IS_TELE) 
        return r 
    endmethod 
    static method LoadX takes integer hid returns real 
        local real r = 0 
        set r = LoadReal(road, hid, Roadline.X) 
        return r 
    endmethod 
    static method LoadY takes integer hid returns real 
        local real r = 0 
        set r = LoadReal(road, hid, Roadline.Y) 
        return r 
    endmethod 
    static method is_have takes rect r returns boolean 
        local boolean res = false 
        local integer n = 0 
        if.i != -1 then 
            loop 
                exitwhen n >.i 
                if r ==.regions[n].r then 
                    set res = true 
                    exitwhen true 
                endif 
                set n = n + 1 
            endloop 
        endif 
        return res 
    endmethod 
    static method find takes region rg returns integer 
        local integer res = -1 
        local integer n = 0 
        if.i != -1 then 
            loop 
                exitwhen n >.i 
                if rg ==.regions[n].rg then 
                    set res = n 
                    exitwhen true 
                endif 
                set n = n + 1 
            endloop 
        endif 
        return res 
    endmethod 
    static method findbyrect takes rect r returns integer 
        local integer res = -1 
        local integer n = 0 
        if.i != -1 then 
            loop 
                exitwhen n >.i 
                if r ==.regions[n].r then 
                    set res = n 
                    exitwhen true 
                endif 
                set n = n + 1 
            endloop 
        endif 
        return res 
    endmethod 
    static method Runto takes nothing returns nothing 
        local region rg = GetTriggeringRegion() 
        local unit u = GetEnteringUnit() 
        local integer id = GetHandleId(u) 
        local integer rgid =.find(rg) 
        local string roadtype = LoadStr(road, id, Roadline.ROAD) 
        local integer n = 0 
        // call PLAYER.systemchat(Player(0),.regions[rgid].name[n])                            
        
        loop 
            exitwhen n >.regions[rgid].size 
            if roadtype ==.regions[rgid].name[n] then 
                call SaveReal(road, id, Roadline.X,.regions[rgid].x[n]) 
                call SaveReal(road, id, Roadline.Y,.regions[rgid].y[n]) 
                call Roadline.SaveDelay(id,.regions[rgid].delay[n]) 
                if.regions[rgid].is_teleport[n] then 
                    call SaveBoolean(road, id, Roadline.IS_TELE, true) 
                else 
                    call SaveBoolean(road, id, Roadline.IS_TELE, false) 
                endif 
                if.regions[rgid].new_road[n] != "" then 
                    call SaveStr(road, id, Roadline.ROAD,.regions[rgid].new_road[n]) 
                endif 
            endif 
            set n = n + 1 
        endloop 
            

    endmethod 
    static method register takes unit u, rect r, string roadname returns nothing 
        local integer id =.findbyrect(r) 
        local integer size = -1 
        local integer hid = GetHandleId(u) 
        if id != -1 then 
            set size =.regions[id].name2id(roadname) 
            if size != -1 then 
                call SaveStr(road, hid, Roadline.ROAD,.regions[id].name[size]) 
                call SaveReal(road, hid, Roadline.X,.regions[id].x[size]) 
                call SaveReal(road, hid, Roadline.Y,.regions[id].y[size]) 
                call SaveInteger(road, hid, Roadline.DELAY,.regions[id].delay[size]) 
                call SaveBoolean(road, hid, Roadline.IS_TELE,.regions[id].is_teleport[size]) 
            endif 
        endif 
    endmethod 
    static method new takes rect r, rect r2, integer delay, string name, string new_road, boolean is_teleport returns nothing 
        local integer id = 0 
        local integer size = 0 
        local boolean b = false 
        if not.is_have(r) then 
            set.i =.i + 1 
            set.regions[.i] = Region.create() 
            set.regions[.i].r = r 
            set.regions[.i].t = CreateTrigger() 
            set.regions[.i].rg = CreateRegion() 
            call RegionAddRect(.regions[.i].rg, r) 
            call TriggerRegisterEnterRegion(.regions[.i].t,.regions[.i].rg, null) 
            call TriggerAddAction(.regions[.i].t, function thistype.Runto) 
            set b = true 
        endif 

        if b then 
            set id =.i 
        else 
            set id =.findbyrect(r) 
        endif 

        set.regions[id].size =.regions[id].size + 1 
        set size =.regions[id].size 
        set.regions[id].name[size] = name 
        set.regions[id].x[size] = GetRectCenterX(r2) 
        set.regions[id].y[size] = GetRectCenterY(r2) 
        set.regions[id].delay[size] = delay 
        set.regions[id].new_road[size] = new_road 
        set.regions[id].is_teleport[size] = is_teleport 

    endmethod 
endstruct 











