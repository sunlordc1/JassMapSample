globals 
    hashtable road = InitHashtable() // For damage system                                            
    constant integer MAX_SIZE_ROADLINE = 99 
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
    static method LoadRoad takes integer hid returns string 
        local string r = "" 
        set r = LoadStr(road, hid, StringHash("road")) 
        return r 
    endmethod 
    static method SaveDelay takes integer hid, integer delaytime returns nothing 
        call SaveInteger(road, hid, StringHash("delay"), delaytime) 
    endmethod 
    static method LoadDelay takes integer hid returns integer 
        local integer r = 0 
        set r = LoadInteger(road, hid, StringHash("delay")) 
        return r 
    endmethod 
    static method LoadX takes integer hid returns real 
        local real r = 0 
        set r = LoadReal(road, hid, StringHash("x")) 
        return r 
    endmethod 
    static method LoadY takes integer hid returns real 
        local real r = 0 
        set r = LoadReal(road, hid, StringHash("y")) 
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
        local string roadtype = LoadStr(road, id, StringHash("road")) 
        local integer n = 0 
        // call PLAYER.systemchat(Player(0),.regions[rgid].name[n])                
        
        loop 
            exitwhen n >.regions[rgid].size 
            if roadtype ==.regions[rgid].name[n] then 
                call SaveReal(road, id, StringHash("x"),.regions[rgid].x[n]) 
                call SaveReal(road, id, StringHash("y"),.regions[rgid].y[n]) 
                call SaveInteger(road, id, StringHash("delay"),.regions[rgid].delay[n]) 
                call PLAYER.systemchat(Player(0),.regions[rgid].name[n]) 
                call PLAYER.systemchat(Player(0), R2S(.regions[rgid].x[n])) 
                call PLAYER.systemchat(Player(0), R2S(.regions[rgid].y[n])) 
                call PLAYER.systemchat(Player(0), I2S(.regions[rgid].delay[n])) 
                call PLAYER.systemchat(Player(0), R2S(LoadReal(road, id, StringHash("x"))) + " [] " + R2S(LoadReal(road, id, StringHash("y")))) 
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
                call SaveStr(road, hid, StringHash("road"),.regions[id].name[size]) 
                call SaveReal(road, hid, StringHash("x"),.regions[id].x[size]) 
                call SaveReal(road, hid, StringHash("y"),.regions[id].y[size]) 
                call SaveReal(road, hid, StringHash("delay"),.regions[id].delay[size]) 
                call BJDebugMsg("REgister delay" + I2S(.regions[id].delay[size])) 
            endif 
        endif 
    endmethod 
    static method new takes rect r, rect r2, integer delay, string name returns nothing 
        local integer id = 0 
        local integer size = 0 
        if not.is_have(r) then 
            set.i =.i + 1 
            set.regions[.i] = Region.create() 
            set.regions[.i].r = r 
            set.regions[.i].t = CreateTrigger() 
            set.regions[.i].rg = CreateRegion() 
            call RegionAddRect(.regions[.i].rg, r) 
            call TriggerRegisterEnterRegion(.regions[.i].t,.regions[.i].rg, null) 
            call TriggerAddAction(.regions[.i].t, function thistype.Runto) 
            set.regions[.i].size =.regions[.i].size + 1 
            set size =.regions[.i].size 
            set.regions[.i].name[size] = name 
            set.regions[.i].x[size] = GetRectCenterX(r2) 
            set.regions[.i].y[size] = GetRectCenterY(r2) 
            // call BJDebugMsg(R2S(.regions[.i].x[size]) + " [] " + R2S(.regions[.i].y[size]))  
            set.regions[.i].delay[size] = delay 

        else 
            set id =.findbyrect(r) 
            set.regions[id].size =.regions[id].size + 1 
            set size =.regions[.i].size 
            set.regions[id].name[size] = name 
            set.regions[id].x[size] = GetRectCenterX(r2) 
            set.regions[id].y[size] = GetRectCenterY(r2) 
            set.regions[.i].delay[size] = delay 
            // call BJDebugMsg(R2S(.regions[.i].x[size]) + " [] " + R2S(.regions[.i].y[size]))  

        endif 

        //Link                                     

        // if not.is_have(r2) then                                            
        //     set.i =.i + 1                                            
        //     set.regions[.i] = Region.create()                                            
        //     set.regions[.i].r = r                                            
        //     //It's for debug                                                  
        //     set.regions[.i].name = name                                            
        //     //Make trigger event                                                  
        //     set.regions[.i].t = CreateTrigger()                                            
        //     set.regions[.i].rg = CreateRegion()                                            
        //     call RegionAddRect(.regions[.i].rg, r)                                            
        //     call TriggerRegisterEnterRegion(.regions[.i].t,.regions[.i].rg, null)                                            
        //     call TriggerAddAction(.regions[.i].t, function thistype.Runto)                                            
        // else                                            

        // endif                                            
    endmethod 
endstruct 












// struct Roadline                                                   
//     rect array Region[MAX_SIZE_ROADLINE]                                                   
//     rect array RoadTo[MAX_SIZE_ROADLINE]                                                   
//     integer array Delay[MAX_SIZE_ROADLINE]                                                   
//     trigger array t[MAX_SIZE_ROADLINE]                                                   
//     integer i = 0                                                   
//     string RoadType = ""                                                   
//     string NextRoad = ""                                                   
//     rect Teleport = null                                                   
//     static method FilterUnit takes nothing returns boolean                                                   

//     endmethod                                                   
//     static method RunTo takes nothing returns nothing                                                   
//         local integer n = 0                                                   
//         local unit u = GetEnteringUnit()                                                   

//         local integer id = GetHandleId(GetEnteringUnit())                                                   
//         if GetPlayerId(GetOwningPlayer(u)) == 10 and ORDER.LoadRoad(id) ==.RoadType then                                                   
//             set n = 0                                                   
//             loop                                                   
//                 exitwhen n >.i                                                   
//                 if RectContainsCoords(.Region[n], GetUnitX(u), GetUnitY(u)) or RectContainsCoords(.Region[n], GetPPX(GetUnitX(u), 150, GetUnitFacing(u)), GetPPY(GetUnitY(u), 150, GetUnitFacing(u))) then                                                   
//                     // call BJDebugMsg("ID: " + I2S(n) + " Delay: " + I2S(.Delay[n]))                                                                                                                                         
//                     call ORDER.SaveDelay(id,.Delay[n])                                                   
//                     call ORDER.Save(id, n)                                                   
//                     // call IssueImmediateOrder(u, "stop")                                                                                                                            
//                     if ORDER.Load(id) == (.i - 1) then                                                   
//                         if.Teleport != null then                                                   
//                             call SetUnitPosition(u, GetRectCenterX(.Teleport), GetRectCenterY(.Teleport))                                                   
//                         endif                                                   
//                         call SaveStr(road, id, StringHash("Road"),.NextRoad)                                                   
//                         call ORDER.Save(id, 0)                                                   
                      
//                     endif                                                   
//                     exitwhen true                                                   
//                 endif                                                   
//                 set n = n + 1                                                   
//             endloop                                                   
//             set u = null                                                   
//         endif                                                   
//     endmethod                                                   
//     static method New takes rect r2, rect r, integer delay returns nothing                                                   
//         set.Region[.i] = r                                                   
//         set.RoadTo[.i] = r2                                                   
//         set.Delay[.i] = delay                                                   
//         set.t[.i] = CreateTrigger()                                                   
//         call TriggerRegisterEnterRectSimple(.t[.i], r)                                                   
        
//         call TriggerAddAction(.t[.i], function thistype.RunTo)                                                   
//         set.i =.i + 1                                                   
//     endmethod                                                   
// endstruct 