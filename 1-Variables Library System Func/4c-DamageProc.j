struct Proc 
    static method BSTAT takes nothing returns nothing 
        // call ItemStat.BonusRequire() //Item Stat          
        // call PassiveSkill.BSTATCalc()   
        // call BuffSkill.BSTATCalc()   
          
        if DMGSTAT.ATK_TYPE == ATTACK_TYPE_NORMAL then 
               
        endif 
    endmethod 
    static method SpellStat takes nothing returns nothing 
        if IsUnitType(DMGSTAT.caster, UNIT_TYPE_HERO) then 
            // set DMGSTAT.dmg = DMGSTAT.dmg + 100  
        endif 
    endmethod 
     
    static method onHit takes nothing returns nothing 
        local real d = 0 
        local real d2 = 0 
        local integer m = 0 
        // call HeroSkill.onHit()    
          
            
    endmethod 
    static method onStuck takes nothing returns nothing 
        local real r = 0 
        local string p = "" 
            
    endmethod 
    static method onLastHit takes nothing returns nothing 
        local real d = 0 
        local real x = 0 
        local real y = 0 
        
    endmethod 
endstruct 