struct SKILL 
    unit caster = null 
    unit target = null 
    unit u = null 
    group g = null 
    damagetype DMG_TYPE = null 
    attacktype ATK_TYPE = null 
    integer time = 0 

    real speed = 0.00 
    real dmg = 0.00 
    real aoe = 0.00 
    real a = 0.00 
    real x = 0.00 
    real y = 0.00 
    real z = 0.00 

    integer buff_id 
    integer buff_lv 
    integer buff_dur 

    effect missle = null 
    string missle_path = "" 
    real missle_size = 0.00 
    boolean is_touch = false 

    boolean ALLOW_GROUND = true 
    boolean ALLOW_FLYING = true 

    boolean ALLOW_HERO = true 
    boolean ALLOW_STRUCTURE = true 
    boolean ALLOW_MECHANICAL = true 
    boolean ALLOW_ENEMY = true 
    boolean ALLOW_ALLY = true 
    boolean ALLOW_MAGIC_IMMUNE = true 

    boolean ALLOW_ALIVE = true 
    method FilterCompare takes boolean is, boolean yes, boolean no returns boolean 
        return(is and yes) or((not is) and no) 
    endmethod 
    method setxyz takes real x, real y, real z returns nothing 
        set.x = x 
        set.y = y 
        set.z = z 
    endmethod 
    method setallow takes boolean ALLOW_HERO, boolean ALLOW_STRUCTURE, boolean ALLOW_FLYING, boolean ALLOW_GROUND, boolean ALLOW_MECHANICAL, boolean ALLOW_ALIVE, boolean ALLOW_MAGIC_IMMUNE returns nothing 
        set.ALLOW_GROUND = ALLOW_GROUND 
        set.ALLOW_FLYING = ALLOW_FLYING 
        set.ALLOW_HERO = ALLOW_HERO 
        set.ALLOW_STRUCTURE = ALLOW_STRUCTURE 
        set.ALLOW_MECHANICAL = ALLOW_MECHANICAL 
        set.ALLOW_ENEMY = ALLOW_ENEMY 
        set.ALLOW_ALLY = ALLOW_ALLY 
        set.ALLOW_MAGIC_IMMUNE = ALLOW_MAGIC_IMMUNE 
        set.ALLOW_ALIVE = ALLOW_ALIVE 
    endmethod 
    method FilterUnit takes unit u, unit caster returns boolean 
        if not.FilterCompare(IsUnitAlly(u, GetOwningPlayer(caster)),.ALLOW_ALLY,.ALLOW_ENEMY) then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_HERO) and not.ALLOW_HERO then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_STRUCTURE) and not.ALLOW_STRUCTURE then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_FLYING) and not.ALLOW_FLYING then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_GROUND) and not.ALLOW_GROUND then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_MECHANICAL) and not.ALLOW_MECHANICAL then 
            return false 
        endif 
        if IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not.ALLOW_MAGIC_IMMUNE then 
            return false 
        endif 
        if GetUnitState(u, UNIT_STATE_LIFE) > 0 and not.ALLOW_ALIVE then 
            return false 
        endif 
        return true 
    endmethod 
endstruct 

struct SKILL_MISSLE extends SKILL 
    
    //=====================FireTouch========================================== 
    private static method FireTouchUpdate takes nothing returns nothing 
        local thistype this = runtime.get() 
        local timer t = GetExpiredTimer() 
        local group g = null 
        local unit e = null 
        set.x = Math.ppx(.x,.speed,.a) 
        set.y = Math.ppy(.y,.speed,.a) 
        call Eff.angle(.missle,.a) 
        call Eff.pos(.missle,.x,.y, Math.pz(.x,.y) +.z) 

        set g = CreateGroup() 
        call Group.enum(g,.x,.y,.aoe) 
        loop 
            set e = FirstOfGroup(g) 
            exitwhen e == null 
            if not.is_touch and.FilterUnit(e,.caster) and e !=.caster then 
                set.is_touch = true 
                call UnitDamageTargetBJ(.caster, e,.dmg,.ATK_TYPE,.DMG_TYPE) 
                call Buff.effect(.caster, e,.buff_id,.x,.y,.buff_lv,.buff_dur) 
            endif 
            call Group.remove(e, g) 
        endloop 
        call Group.release(g) 
        set e = null 

        set.time =.time - 1 
        if.time <= 0 or GetUnitState(.caster, UNIT_STATE_LIFE) <= 0 or.is_touch then 
            call DestroyEffect(.missle) 
            call runtime.endx(t) // End the timer                                                                                                                                                                          
            call.destroy() // Destroy the instance                                      
        endif 
    endmethod 
    method FireTouch takes nothing returns boolean 
        // local thistype this = thistype.create()                  
        set.missle = Eff.new(.missle_path,.x,.y, Math.pz(.x,.y) +.z) 
        call Eff.size(.missle,.missle_size) 
        call Eff.angle(.missle,.a) 
        if ENV_DEV then 
            call PLAYER.systemchat(Player(0), "[SKILL] Fire Touch") 
            call PLAYER.systemchat(Player(0), missle_path) 
        endif 
        call runtime.new(this, P32, true, function thistype.FireTouchUpdate) 
        return false 
    endmethod 
    //=================================================================================== 


    //=====================FirePierce========================================== 
    private static method FirePierceUpdate takes nothing returns nothing 
        local thistype this = runtime.get() 
        local timer t = GetExpiredTimer() 
        local group g = null 
        local unit e = null 
        set.x = Math.ppx(.x,.speed,.a) 
        set.y = Math.ppy(.y,.speed,.a) 
        call Eff.angle(.missle,.a) 
        call Eff.pos(.missle,.x,.y, Math.pz(.x,.y) +.z) 

        set g = CreateGroup() 
        call Group.enum(g,.x,.y,.aoe) 
        loop 
            set e = FirstOfGroup(g) 
            exitwhen e == null 
            if not IsUnitInGroup(e,.g) and.FilterUnit(e,.caster) and e !=.caster then 
                call Group.add(e,.g) 
                call UnitDamageTargetBJ(.caster, e,.dmg,.ATK_TYPE,.DMG_TYPE) 
                call Buff.effect(.caster, e,.buff_id,.x,.y,.buff_lv,.buff_dur) 
            endif 
            call Group.remove(e, g) 
        endloop 
        call Group.release(g) 
        set e = null 

        set.time =.time - 1 
        if.time <= 0 or GetUnitState(.caster, UNIT_STATE_LIFE) <= 0 then 
            call Group.release(.g) 
            call DestroyEffect(.missle) 
            call runtime.endx(t) // End the timer                                                                                                                                                                          
            call.destroy() // Destroy the instance                                      
        endif 
    endmethod 
    method FirePierce takes nothing returns boolean 
        // local thistype this = thistype.create()                  
        set.missle = Eff.new(.missle_path,.x,.y, Math.pz(.x,.y) +.z) 
        call Eff.size(.missle,.missle_size) 
        call Eff.angle(.missle,.a) 
        set.g = CreateGroup() 
        if ENV_DEV then 
            call PLAYER.systemchat(Player(0), "[SKILL] Fire Touch") 
            call PLAYER.systemchat(Player(0), missle_path) 
        endif 
        call runtime.new(this, P32, true, function thistype.FirePierceUpdate) 
        return false 
    endmethod 
    //=================================================================================== 

endstruct