
//About code : https://docs.google.com/document/d/1WXxXdxNFZzz-QFSk-mtlMsDn1jJUn9v5NOE83cVnAC8/edit?usp=sharing 
//Uses check example in 4-Event/10- Player - Chat.j
//====Variables in struct 
//  static RANDOM_POOL pool1 
//====Setting 
// set.pool1 = RANDOM_POOL.create() 
// call.pool1.new_value(1, 50, 0, 0) 
// call.pool1.new_value(2, 30, 0, 5) 
// call.pool1.new_value(3, 20, 0, 2) 
//====Call when want random
// set random_value = .pool1.random() 

//Set size array 10 to higher if u have more value            
struct RANDOM_POOL 
    integer array value[10] //Use for raw or number or id item                                
    real array rate_default[10] //Constant rate default                                
    real array rate[10] // Rate now of item                                
    real array increase[10] //When drop call a time, rate = rate + increase                                
    integer times //When the drop call a time, it increase 1                                 
    integer size = -1 
    method new_value takes integer value, integer rate_default, integer rate, integer increase returns nothing 
        set.size =.size + 1 
        set.value[.size] = value 
        set.rate_default[.size] = rate_default 
        set.rate[.size] = rate + rate_default 
        set.increase[.size] = increase 
    endmethod 
    method update_rate takes nothing returns nothing 
        set bj_int = 0 
        loop 
            exitwhen bj_int >.size 
            set.rate[bj_int] =.rate[bj_int] +.increase[bj_int] 
            set bj_int = bj_int + 1 
        endloop 
    endmethod 
    method total takes nothing returns real 
        local real total = 0 
        set bj_int = 0 
        loop 
            exitwhen bj_int >.size 
            set total = total +.rate[bj_int] 
            set bj_int = bj_int + 1 
        endloop 
        return total 
    endmethod 
    method random takes nothing returns integer 
        local integer v = -1 
        local real total = 0 
        local real random_val = 0 
        local real accumulated = 0 
        set total =.total() 
  
        set random_val = GetRandomReal(0, total) 
        if ENV_DEV then 
            call BJDebugMsg("random_val: " + R2S(random_val) + " / " + "Total: " + R2S(total)) 
            call BJDebugMsg("Number of Value Random: " + I2S(.size + 1)) 
        endif 
        set bj_int = 0 
        loop 
            exitwhen bj_int >.size 
            set accumulated = accumulated +.rate[bj_int] 
            if random_val <= accumulated then 
                set v =.value[bj_int] 
                call.action(bj_int) // Make some stupid code               
                call.update_rate() 
                set.times =.times + 1 
                exitwhen true 
            endif 
            set bj_int = bj_int + 1 
        endloop 
        if ENV_DEV then 
            call BJDebugMsg(".accumulated: " + R2S(accumulated) + " [] Values: " + R2S(v) + "[] Times: " + R2S(times)) 
        endif 

        return v 
    endmethod 
    method action takes integer index returns nothing 
        //Code for example                 
        if.times == 5 then 
            call BJDebugMsg("Critical DROP! 5 times") 

        endif 
        if index == 2 then 
            call BJDebugMsg("Critical DROP! reset rate to default") 
            //Reset when the value [9] drop                
            set bj_int = 0 
            loop 
                exitwhen bj_int >.size 
                set.rate[bj_int] =.rate_default[bj_int] 
                set bj_int = bj_int + 1 
            endloop 
        endif 
    endmethod 
endstruct 
