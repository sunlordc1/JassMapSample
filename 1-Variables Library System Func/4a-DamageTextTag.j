
struct TextDmg 
    static real text_size = 10 
    static real zOffset = 0 
    static real lifespan = 0.725 
    static real speed = 96 
    static real angle = 120 
    static boolean permanent = false 
    static real fadepoint = 1.00 
    static method setting takes texttag tt returns nothing 
        call Texttag.velocity(tt,.speed,.angle) 
        call Texttag.permanent(tt,.permanent) 
        call Texttag.fadepoint(tt,.fadepoint) 
        call Texttag.lifespan(tt,.lifespan) 
    endmethod 
    static method run takes string colorName, real dmg, unit victim, unit caster returns boolean 
        local integer cid = GetPlayerId(GetOwningPlayer(caster)) 
        local integer vid = GetPlayerId(GetOwningPlayer(victim)) 
        local texttag tt = null 
        if colorName == "Physical" then 
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 100.00, 100, 100, 0) 
        elseif colorName == "Spell" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 10.00, 50, 80, 0) 
        elseif colorName == "Cold" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 0.00, 60.00, 80.00, 0) 
        elseif colorName == "Poison" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 10.00, 100, 10.00, 0) 
        elseif colorName == "Fire" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 100.00, 20.00, 0.00, 0) 
        elseif colorName == "Lightning" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 93.00, 93.00, 0, 0)
        elseif colorName == "Crit" then
            set tt = Texttag.unit("-" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 89.00, 51.00, 6.00, 0)
        elseif colorName == "Miss" then
            set tt = Texttag.unit("Miss !", victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 30.00, 74.00, 20.00, 0) 
        elseif colorName == "Block" then
            set tt = Texttag.unit("Block !", victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 70.00, 70.00, 70.00, 0) 
        elseif colorName == "Heal" then
            set tt = Texttag.unit("+" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 0, 60, 0, 0) 
        elseif colorName == "HealMana" then
            set tt = Texttag.unit("+" + Num.ri2s(dmg), victim,.zOffset,.text_size) 
            call Texttag.colorpercent(tt, 0, 0, 153, 0) 
        endif
        if tt != null then 
            call.setting(tt) 
            if(colorName == "Crit") then 
                call Texttag.text(tt, Num.ri2s(dmg),.text_size + 3) 
            endif 
        endif 
        return false 
    endmethod 
endstruct 
