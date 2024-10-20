struct BSTAT 
    static integer crit_chance = StringHash("CritChance") 
    static integer crit_dmg = StringHash("CritDmg") 
    static real crit_dmg_default = 135 
    static real crit_chance_default = 0 

    static integer evasion = StringHash("Evasion") 
    static integer resist_spell = StringHash("ResistSpell") 
    static integer pierce_spell = StringHash("PierceSpell") 
endstruct 
struct DMGSTAT 
    static real dmg = 0.00 
    static unit victim 
    static unit caster 
    static attacktype ATK_TYPE 
    static damagetype DMG_TYPE 
    static integer uidc = 0 
    static integer uidv = 0 
    static integer idv = 0 
    static integer idc = 0 
    static real armor = 0.00 
    static real crit_dmg = 0.00 
    static real crit_chance = 0.00 
    static real evasion = 0.00 
    static real resist_spell = 0.00 
    static real pierce_spell = 0.00 

    static method f_Get_DMGSTAT takes nothing returns nothing 
        set.armor = BlzGetUnitArmor(DMGSTAT.victim) 
        set.uidc = GetUnitTypeId(DMGSTAT.caster) 
        set.uidv = GetUnitTypeId(DMGSTAT.victim) 
        set.idv = GetHandleId(DMGSTAT.victim) 
        set.idc = GetHandleId(DMGSTAT.caster) 
        set.crit_dmg = BSTAT.crit_dmg_default + (LoadReal(stats,.idc, BSTAT.crit_dmg)) 
        set.crit_chance = BSTAT.crit_chance_default + LoadReal(stats,.idc, BSTAT.crit_chance) 
        set.evasion = 0 + LoadReal(stats,.idv, BSTAT.evasion) 
        set.resist_spell = 0 + LoadReal(stats,.idv, BSTAT.resist_spell) 
        set.pierce_spell = 0 + LoadReal(stats,.idc, BSTAT.pierce_spell) 

    endmethod 
    static method f_Reset_DMGSTAT takes nothing returns nothing 
        set.uidc = 0 
        set.uidv = 0 
        set.idv = 0 
        set.idc = 0 
        set.armor = 0.00 
        set.crit_dmg = 0.00 
        set.crit_chance = 0.00 
        set.evasion = 0.00 
      
    endmethod 
endstruct 
struct DMGEVENT 
    static trigger t = CreateTrigger() 
    private static method DamageEvent takes nothing returns nothing 
        call DisableTrigger(GetTriggeringTrigger()) 
        set DMGSTAT.caster = GetEventDamageSource() 
        set DMGSTAT.victim = BlzGetEventDamageTarget() 
        set DMGSTAT.dmg = GetEventDamage() 
        
        call TriggerExecute(.t) 
        set DMGSTAT.caster = null 
        set DMGSTAT.victim = null 
        call EnableTrigger(GetTriggeringTrigger()) 
    endmethod 
    static method Damaged takes nothing returns nothing 
        local string color_dmg_type 
        local real chance_hit = 0 
        // local boolean IsBoss = LoadBoolean(road, DMGSTAT.idv, StringHash("Boss")) 
        call DMGSTAT.f_Reset_DMGSTAT() 
        call DMGSTAT.f_Get_DMGSTAT() 
        set DMGSTAT.ATK_TYPE = BlzGetEventAttackType() 
        set DMGSTAT.DMG_TYPE = BlzGetEventDamageType() 
        if DMGSTAT.dmg > 0.00 then 
            //Text Damage                                        
            call Proc.BSTAT() 
            // if Math.rate(RMaxBJ(0, DMGSTAT.evasion - DMGSTAT.attack_rating)) then        
            if Math.rate(RMaxBJ(0, DMGSTAT.evasion)) then 
                // call BJDebugMsg("miss")                                        
                set chance_hit = 0 
            else 
                set chance_hit = 1 
            endif 

            if BlzGetEventAttackType() != ATTACK_TYPE_NORMAL then 
                set color_dmg_type = "Physical" 
                if BlzGetEventAttackType() == ATTACK_TYPE_CHAOS then 
                    set color_dmg_type = "Chao" 
                endif 
                if BlzGetEventAttackType() == ATTACK_TYPE_HERO then 

                endif 
                if BlzGetEventDamageType() == DAMAGE_TYPE_NORMAL then 
                

                    if(chance_hit > 0 and DMGSTAT.dmg > 0) then 
                      
                        call Proc.onHit() 

                        ///                                        
                        // call BJDebugMsg(R2S(DMGSTAT.crit_chance))                                        
                        if Math.rate(DMGSTAT.crit_chance) then 
                            // call BJDebugMsg(R2S(DMGSTAT.crit_dmg))                                        
                            set DMGSTAT.dmg = DMGSTAT.dmg * (DMGSTAT.crit_dmg / 100) 
                            set color_dmg_type = "Crit" 
                        endif 
                        call Proc.onStuck() 
                    else 
                        if(chance_hit == 0) then 
                            set DMGSTAT.dmg = 0 
                            set color_dmg_type = "Miss" 
                        endif 
                    endif 

                

                    if BlzGetEventAttackType() == ATTACK_TYPE_CHAOS then 
              
                    endif 
                    // if DMGSTAT.life_steal > 0 then   
                    //     // call BJDebugMsg("heal" + R2S(DMGSTAT.dmg * DMGSTAT.v_LifeSteal_DMGSTAT))                                        
                    //     // call EFFECT.Heal(DMGSTAT.dmg * DMGSTAT.v_LifeSteal_DMGSTAT, DMGSTAT.caster, DMGSTAT.caster)                                        
                    // endif   
                    if DMGSTAT.dmg <= 0 and color_dmg_type != "Miss" then 
                        set color_dmg_type = "Block" 
                    endif 
                endif 
               
            endif 
            // ATTACK TYPE : SPELL                                        
            if BlzGetEventAttackType() == ATTACK_TYPE_NORMAL then 
                //Calc Damage & Text                                        
                call Proc.SpellStat() 
                set color_dmg_type = "Spell" 
                // DAMAGE TYPE : COLD                                        
                if BlzGetEventDamageType() == DAMAGE_TYPE_COLD then 
                    set color_dmg_type = "Cold" 
                endif 
                // DAMAGE TYPE : POISON                                        
                if BlzGetEventDamageType() == DAMAGE_TYPE_POISON then 
                    set color_dmg_type = "Poison" 
                endif 
                if BlzGetEventDamageType() == DAMAGE_TYPE_SHADOW_STRIKE then 
                    set color_dmg_type = "Poison" 
                endif 
                if BlzGetEventDamageType() == DAMAGE_TYPE_DEATH then 
                    set color_dmg_type = "" 
                endif 
                if BlzGetEventDamageType() == DAMAGE_TYPE_DEMOLITION then 
                    set color_dmg_type = "" 
                endif 
                // DAMAGE TYPE : FIRE                                        
                if BlzGetEventDamageType() == DAMAGE_TYPE_FIRE then 
                    set color_dmg_type = "Fire" 
                endif 
                // DAMAGE TYPE: CHAIN OF LIGHNING                                        
                if BlzGetEventDamageType() == DAMAGE_TYPE_LIGHTNING then 
                    set color_dmg_type = "Lightning" 
                    //Healing Wave                        
                    if GetOwningPlayer(DMGSTAT.caster) == GetOwningPlayer(DMGSTAT.victim) then 
                        set color_dmg_type = "Heal" 
                        // Trick healing wave set - damage on ally then detect healing wave now 
                        // set DMGSTAT.dmg = 0  
                    endif 
                endif 
                // DAMAGE TYPE: Unknown                                        
                if BlzGetEventDamageType() == DAMAGE_TYPE_MAGIC then 
                    // Mana burn                                        
                endif 
                set DMGSTAT.resist_spell = DMGSTAT.resist_spell - DMGSTAT.pierce_spell 
                set DMGSTAT.dmg = RMaxBJ(0, DMGSTAT.dmg - (DMGSTAT.dmg * (DMGSTAT.resist_spell / 100))) 
            endif 
            
            if DMGSTAT.dmg <= 0 then 
                if color_dmg_type != "Miss" then 
                    set color_dmg_type = "Block" 
                endif 
            endif 
            // call BJDebugMsg(R2S(DMGSTAT.dmg))                                        
        endif 
       

        if Unit.life(DMGSTAT.victim) <= DMGSTAT.dmg + 1 or Unit.life(DMGSTAT.victim) <= DMGSTAT.dmg then 
            call Proc.onLastHit() 
        endif 
       
        call BlzSetEventDamage(DMGSTAT.dmg) 
        call createTextTagDamage(color_dmg_type, DMGSTAT.dmg, DMGSTAT.victim, DMGSTAT.caster)     
    endmethod 
    private static method onInit takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, ConvertPlayerUnitEvent(308)) 
        call TriggerAddAction(t, function thistype.DamageEvent) 
        set t = null 
        call DisableTrigger(.t) 
        call TriggerAddAction(.t, function thistype.Damaged) 
    endmethod 
endstruct