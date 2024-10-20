struct EV_START_SPELL_EFFECT 
    static method f_Checking takes nothing returns boolean 
        local unit caster = GetTriggerUnit() 
        local integer idc = GetUnitTypeId(caster) 
        local unit target = GetSpellTargetUnit() 
        local integer idt = GetUnitTypeId(target) 
        local integer abicode = GetSpellAbilityId() 
        local item it = GetSpellTargetItem() 
        local real targetX = GetSpellTargetX() //Point X of skill                  
        local real targetY = GetSpellTargetY() //Point T of skill                  
        local integer pid = GetPlayerId(GetOwningPlayer(caster)) 
        local integer tpid = GetPlayerId(GetOwningPlayer(target)) 
        local real xc = GetUnitX(caster) 
        local real yc = GetUnitY(caster) 
        local real xt = GetUnitX(target) //Position X of target unit                 
        local real yt = GetUnitY(target) //Position T of target unit                 
        local SKILL_MISSLE Missle 
        local integer n = 1 

        if abicode == 'A000' then 
            loop 
                exitwhen n > 5 
                set Missle = SKILL_MISSLE.create() 
                set Missle.caster = caster 
                call Missle.setxyz(xc, yc, 100) 
                //Angle     
                set Missle.a = (Math.ab(xc, yc, targetX, targetY) -(3 * 20)) + (n * 20) 
                //Speed per tick (1 second = speed *32)     
                set Missle.missle_path = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl" 
                set Missle.missle_size = 1.5 
                set Missle.speed = 15 
                set Missle.aoe = 50 
                set Missle.dmg = 35 
                set Missle.time = 32 * 2 // 32 tick per 1 seconds   

                if GetRandomInt(0, 1) == 0 then 
                    set Missle.buff_id = Buff.STUN 
                else 
                    set Missle.buff_id = Buff.SLOW 
                endif 
                set Missle.buff_lv = 1 

                set Missle.ATK_TYPE = ATTACK_TYPE_NORMAL 
                set Missle.DMG_TYPE = DAMAGE_TYPE_FIRE 
                call Missle.setallow(true, false, true, true, false, true, false) 
          
                call Missle.FireTouch() 
                set n = n + 1 
            endloop 
        
        endif 

        set target = null 
        set caster = null 
        set it = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 

