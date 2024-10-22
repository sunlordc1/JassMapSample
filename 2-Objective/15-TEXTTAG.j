//call CreateTextTagUnitBJ("TRIGSTR_020", GetLastCreatedUnit(), 0, 10, 100, 100, 100, 0)          
//call SetTextTagAgeBJ(GetLastCreatedTextTag(), 0) //         
// call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4)         
// call SetTextTagPermanentBJ(GetLastCreatedTextTag(), true)         
// call SetTextTagSuspendedBJ(GetLastCreatedTextTag(), true)        
// call SetTextTagTextBJ(GetLastCreatedTextTag(), "TRIGSTR_022", 10)      
// call SetTextTagPosUnitBJ(GetLastCreatedTextTag(), GetLastCreatedUnit(), 0)      
// call SetTextTagPosBJ(GetLastCreatedTextTag(), GetRectCenter(GetPlayableMapRect()), 0)     
// call SetTextTagColorBJ(GetLastCreatedTextTag(), 100, 100, 100, 0)     
// call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 64, 90)   
call ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll()) 
call DestroyTextTagBJ(GetLastCreatedTextTag()) 
struct TEXTTAG 
    //Use:             
    //set bj_loc = MoveLocation(x,y)             
    //call TEXTTAG.newloc(str, bj_loc, z , size)               
    static method new takes string str, location loc, real Zoffset, real size returns texttag 
        set bj_texttag = CreateTextTag() 
        call SetTextTagText(bj_texttag, s, (size * 0.023) / 10) 
        call SetTextTagPos(bj_texttag, GetLocationX(loc), GetLocationY(loc), Zoffset) 
        call SetTextTagColor(bj_texttag, 255, 255, 255, 255) 
        return bj_texttag 
    endmethod 
    static method unit takes string str, unit u, real Zoffset, real size returns texttag 
        set bj_texttag = CreateTextTag() 
        call SetTextTagText(bj_texttag, s, (size * 0.023) / 10) 
        call SetTextTagPosUnit(bj_texttag, u, zOffset) 
        call SetTextTagColor(bj_texttag, 255, 255, 255, 255) 
        return bj_texttag 
    endmethod 
    static method last takes nothing returns texttag 
        return bj_texttag 
    endmethod 
    //Use: call TEXTTAG.color(tt,0-255,0-255,0-255,0-255,0-255)               
    static method color takes texttag tt, integer red, integer green, integer blue, real transparency returns nothing 
        call SetTextTagColor(tt, red, green, blue, transparency) 
    endmethod 
    static method age takes texttag tt, real age returns nothing 
        call SetTextTagAge(tt, age) 
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
    static method posunit takes texttag tt, unit u, real Zoffset returns nothing 
        call SetTextTagPosUnit(tt, u, zOffset) 
    endmethod 
    //Uses:        
    //set bj_loc = MoveLocation(x,y)             
    //call TEXTTAG.posloc(str, bj_loc, z , size)         
    static method posloc takes texttag tt, location loc, real Zoffset returns nothing 
        call SetTextTagPos(tt, GetLocationX(loc), GetLocationY(loc), zOffset) 
    endmethod 
    static method show takes texttag tt, force whichForce, boolean show returns nothing 
        if(IsPlayerInForce(GetLocalPlayer(), whichForce)) then 
            // Use only local code (no net traffic) within this block to avoid desyncs.  
            call SetTextTagVisibility(tt, show) 
        endif 
    endmethod 
    static method destroy takes texttag tt returns nothing 
        call DestroyTextTag(tt) 
    endmethod 
endstruct