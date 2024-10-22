
struct Texttag 
    //Use:                    
    //set bj_loc = MoveLocation(x,y)                    
    //call TEXTTAG.newloc(str, bj_loc, z , size)                      
    static method new takes string str, location loc, real zoffset, real size returns texttag 
        set bj_texttag = CreateTextTag() 
        call SetTextTagText(bj_texttag, str, (size * 0.023) / 10) 
        call SetTextTagPos(bj_texttag, GetLocationX(loc), GetLocationY(loc), zoffset) 
        call SetTextTagColor(bj_texttag, 255, 255, 255, 255) 
        return bj_texttag 
    endmethod 
    static method unit takes string str, unit u, real zoffset, real size returns texttag 
        set bj_texttag = CreateTextTag() 
        call SetTextTagText(bj_texttag, str, (size * 0.023) / 10) 
        call SetTextTagPosUnit(bj_texttag, u, zoffset) 
        call SetTextTagColor(bj_texttag, 255, 255, 255, 255) 
        return bj_texttag 
    endmethod 
    static method last takes nothing returns texttag 
        return bj_texttag 
    endmethod 
    //Use: call TEXTTAG.color(tt,0-255,0-255,0-255,0-255,0-255)                      
    static method color takes texttag tt, integer red, integer green, integer blue, integer transparency returns nothing 
        call SetTextTagColor(tt, red, green, blue, transparency) 
    endmethod 
    static method colorpercent takes texttag tt, real red, real green, real blue, real transparency returns nothing 
        call SetTextTagColor(tt, PercentToInt(red, 255), PercentToInt(green, 255), PercentToInt(blue, 255), PercentToInt((100.0 - transparency), 255)) 
    endmethod 
    static method age takes texttag tt, real age returns nothing 
        call SetTextTagAge(tt, age) 
    endmethod 
    static method lifespan takes texttag tt, real lifespan returns nothing 
        call SetTextTagLifespan(tt, lifespan) 
    endmethod 
    static method fadepoint takes texttag tt, real fadepoint returns nothing 
        call SetTextTagFadepoint(tt, fadepoint) 
    endmethod 
    static method velocity takes texttag tt, real speed, real angle returns nothing 
        local real vel = (speed * 0.071) / 128 
        local real xvel = vel * Cos(angle * bj_DEGTORAD) 
        local real yvel = vel * Sin(angle * bj_DEGTORAD) 
        call SetTextTagVelocity(tt, xvel, yvel) 
    endmethod 
    static method permanent takes texttag tt, boolean flag returns nothing 
        call SetTextTagPermanent(tt, flag) 
    endmethod 
    static method suspended takes texttag tt, boolean flag returns nothing 
        call SetTextTagSuspended(tt, flag) 
    endmethod 
    static method text takes texttag tt, string str, real size returns nothing 
        call SetTextTagText(tt, str, (size * 0.023) / 10) 
    endmethod 
    //Uses: Move texttag to point of unit           
    static method posunit takes texttag tt, unit u, real zoffset returns nothing 
        call SetTextTagPosUnit(tt, u, zoffset) 
    endmethod 
    //Uses: Move texttag to point x ,y           
    //set bj_loc = MoveLocation(x,y)                    
    //call TEXTTAG.posloc(str, bj_loc, z , size)                
    static method posloc takes texttag tt, location loc, real zoffset returns nothing 
        call SetTextTagPos(tt, GetLocationX(loc), GetLocationY(loc), zoffset) 
    endmethod 
    static method showforce takes texttag tt, force whichForce, boolean show returns nothing 
        if(IsPlayerInForce(GetLocalPlayer(), whichForce)) then 
            // Use only local code (no net traffic) within this block to avoid desyncs.         
            call SetTextTagVisibility(tt, show) 
        endif 
    endmethod 
    static method destroytt takes texttag tt returns nothing 
        call DestroyTextTag(tt) 
    endmethod 
endstruct