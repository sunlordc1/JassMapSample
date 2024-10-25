struct Buff 
    static boolean array is_target 
    static boolean array is_point 
    static boolean array is_notarget 
    static string array order_name 
    static integer array ability_id 
    static integer id = -1 
    static integer STUN = 0 
    static integer SLOW = 0 
    private static method newbuff takes boolean is_target, boolean is_point, boolean is_notarget, string order_name, integer ability_id returns nothing 
        set.id =.id + 1 
        set.is_target[.id] = is_target 
        set.is_point[.id] = is_point 
        set.is_notarget[.id] = is_notarget 
        set.order_name[.id] = order_name 
        set.ability_id[.id] = ability_id 
        call Preload_Ability(ability_id) 
    endmethod 
    static method effect takes unit caster, unit target, integer buff_id, real x, real y, integer buff_lv, integer buff_dur returns boolean 
        if ENV_DEV then 
            call PLAYER.systemchat(Player(0), "[] buff_id:" + I2S(buff_id) + " [] level: " + I2S(buff_lv)) 
        endif 
        //You can custom buff your rule, here is example                                       
        if buff_id > -1 and buff_id <= id then 
            if.is_target[buff_id] and not IsUnitDeadBJ(target) and target != null then 
                call Dummy.target(.order_name[buff_id], Dummy.load, target,.ability_id[buff_id], buff_lv) 
                // if ENV_DEV then         
                //     call PLAYER.systemchat(Player(0), "[] Target")         
                // endif         
                return false 
            endif 
            if.is_point[buff_id] then 
                call Dummy.newx(Num.pid(GetOwningPlayer(caster))) 
                call UnitApplyTimedLife(bj_unit, 'BTLF', buff_dur) // time for u finish cast or channeling spell then dummy will destroy      
                call Dummy.point(.order_name[buff_id], Dummy.load, x, y, buff_lv,.ability_id[buff_id]) 

                return false 
            endif 
            if.is_notarget[buff_id] then 
                call Dummy.newx(Num.pid(GetOwningPlayer(caster))) 
                call UnitApplyTimedLife(bj_unit, 'BTLF', buff_dur) // time for u finish cast or channeling spell then dummy will destroy      
                call Dummy.notarget(.order_name[buff_id], Dummy.load, x, y, buff_lv,.ability_id[buff_id]) 
                return false 
            endif 
        endif 
        return false 
    endmethod 
    private static method onInit takes nothing returns nothing 
        call.newbuff(true, false, false, "creepthunderbolt", 'A001') 
        set.STUN =.id 
        call.newbuff(true, false, false, "slow", 'A002') 
        set.SLOW =.id 
    endmethod 
endstruct