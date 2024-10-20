function settingTextTag takes texttag text returns nothing 
    call SetTextTagVelocityBJ(text, 96.00, 60.00) 
    call SetTextTagPermanentBJ(text, false) 
    call SetTextTagFadepointBJ(text, 1.00) 
    call SetTextTagLifespanBJ(text, 0.725) 
endfunction 
function settingTextTag2 takes texttag text returns nothing 
    call SetTextTagVelocityBJ(text, 96.00, 120.00) 
    call SetTextTagPermanentBJ(text, false) 
    call SetTextTagFadepointBJ(text, 1.00) 
    call SetTextTagLifespanBJ(text, 0.725) 
endfunction 
// function block takes real damage, real blockdamage returns real         
//     set damage = damage - blockdamage        
//     return damage        
// endfunction        

function createTextTagDamage takes string colorName, real dmg, unit victim, unit caster returns boolean 
    local texttag text 
    local integer id = GetPID(GetOwningPlayer(caster)) 
    local real textsize = 10 
    if GetUID(caster) != GetPlayerNeutralAggressive() then 
        if GetLocalPlayer() == GetOwningPlayer(victim) then 
            if(colorName == "Gold") then 
                set text = CreateTextTagUnitBJ(("+ " + I2S(R2I(dmg))), victim, 0, textsize, 93.00, 79, 0, 0) 
                call settingTextTag(text) 
                return false 
            endif 
        endif 
        if GetLocalPlayer() == GetOwningPlayer(caster) then 
      
            if dmg > 1 then 
                // if dmg > 1  and IsHero2(caster) then        
            
                if(colorName == "Physical") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 100.00, 100, 100, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
   
                if(colorName == "Spell") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 10.00, 50, 80, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Cold") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 0.00, 60.00, 80.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Poison") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 10.00, 100, 10.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Sonic") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 29.00, 91.00, 74.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Dark") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 36.00, 14.00, 43.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Fire") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 100.00, 20.00, 0.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Lightning") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 93.00, 93.00, 0, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Crit") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg)) + "!"), victim, 0, textsize + 1.5, 89.00, 51.00, 6.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Crit Spell") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 97.00, 46.00, 19.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
                if(colorName == "Chao") then 
                    set text = CreateTextTagUnitBJ(("- " + I2S(R2I(dmg))), victim, 0, textsize, 80.00, 0.00, 80.00, 0) 
                    call settingTextTag(text) 
                    return false 
                endif 
            endif 
            
        endif 
        
    endif 
    if GetLocalPlayer() == GetOwningPlayer(caster) or GetLocalPlayer() == GetOwningPlayer(victim) then 
        if(colorName == "Miss") then 
            set text = CreateTextTagUnitBJ(("Miss"), victim, 0, 7.50, 30.00, 74.00, 20.00, 0) 
            call settingTextTag(text) 
            return false 
        endif 
        if(colorName == "Block") then 
            set text = CreateTextTagUnitBJ(("Block !"), victim, 0, 6.00, 70.00, 70.00, 70.00, 0) 
            call settingTextTag2(text) 
        endif 
    endif 
    if(colorName == "Heal") then 
        set text = CreateTextTagUnitBJ(("+" + I2S(R2I(dmg))), victim, 0, textsize - 1, 0, 60, 0, 0) 
        call settingTextTag(text) 
        return false 
    endif 
    if(colorName == "HealMana") then 
        set text = CreateTextTagUnitBJ(("+" + I2S(R2I(dmg))), victim, 0, textsize - 1, 0, 0, 153, 0) 
        call settingTextTag(text) 
        return false 
    endif 
    return false 
endfunction 