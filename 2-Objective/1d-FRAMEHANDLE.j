
//Frame is in a higher category of map editing; I only provide a simple solution for this section.
struct Frame 
    static key KEY_FF 
    static method init takes nothing returns nothing 
        call BlzLoadTOCFile("war3mapImported\\ek_frame2.toc") 
    endmethod 
    static method hidex takes integer id, framehandle f returns nothing 
        if GetLocalPlayer() == Player(id) then 
            call BlzFrameSetVisible(f, false) 
        endif 
    endmethod 
    static method showx takes integer id, framehandle f returns nothing 
        if GetLocalPlayer() == Player(id) then 
            call BlzFrameSetVisible(f, true) 
        endif 
    endmethod 
    static method hide takes framehandle f returns nothing 
        call BlzFrameSetVisible(f, false) 
    endmethod 
    static method show takes framehandle f returns nothing 
        call BlzFrameSetVisible(f, true) 
    endmethod 
    static method fixed takes integer id returns nothing 
        local framehandle f = null 
        if GetHandleId(GetTriggerEventId()) == 310 then    
            set f = BlzGetTriggerFrame() 
            if f != null then 
                if GetLocalPlayer() == Player(id) then 
       
                    call BlzFrameSetEnable(f, false) 
                    call BlzFrameSetEnable(f, true) 
                endif 
            endif 
            set f = null 
        endif 
    endmethod 
    static method debug takes nothing returns nothing 
        call.fixed(Num.pid(GetTriggerPlayer())) 
    endmethod 
    static method get takes nothing returns framehandle 
        return BlzGetTriggerFrame() 
    endmethod 
    static method texts takes integer id, framehandle f, string txt returns nothing 
        if GetLocalPlayer() == Player(id) then 
            call BlzFrameSetText(f, txt) 
        endif 
    endmethod 
    static method text takes string s returns framehandle 
        local framehandle ff = BlzCreateSimpleFrame("TextUnitLevel", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0) 
        call BlzFrameSetLevel(ff, 6) 
        set ff = BlzGetFrameByName("TextUnitLevelValue", 0) 
        call BlzFrameSetText(ff, s) 
        return ff 
    endmethod 
    static method text_noshadow takes string s returns framehandle 
        local framehandle ff = BlzCreateSimpleFrame("TextUnitLevelNS", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0) 
        call BlzFrameSetLevel(ff, 6) 
        set ff = BlzGetFrameByName("TextUnitLevelValueNS", 0) 
        call BlzFrameSetText(ff, s) 
        return ff 
    endmethod 

    static method imagex takes string s, integer level returns framehandle 
        local framehandle ff 
        local framehandle f_goc = BlzCreateSimpleFrame("TestTexture", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0) 
        set ff = BlzGetFrameByName("TestTextureValue", 0) 
        call BlzFrameSetTexture(ff, s, 0, true) 
        call BlzFrameSetLevel(f_goc, level) 
        call BlzFrameClearAllPoints(f_goc) 
        call SaveFrameHandle(ht,.KEY_FF, GetHandleId(f_goc), ff) 
        set ff = null 
        return f_goc 
    endmethod 
    static method base takes framehandle A, framehandle theparent returns nothing 
        call BlzFrameSetPoint(A, FRAMEPOINT_BOTTOMLEFT, theparent, FRAMEPOINT_BOTTOMLEFT, 0, 0) 
        call BlzFrameSetPoint(A, FRAMEPOINT_TOPRIGHT, theparent, FRAMEPOINT_TOPRIGHT, 0, 0) 
    endmethod 
    static method movex takes framehandle ff, real X, real Y, real x, real y returns nothing 
        call BlzFrameSetAbsPoint(ff, FRAMEPOINT_TOPRIGHT, x + X, y + Y) 
        call BlzFrameSetAbsPoint(ff, FRAMEPOINT_BOTTOMLEFT, x, y) 
    endmethod 
    static method changetexture takes framehandle ff, string icon returns nothing 
        call BlzFrameSetTexture(LoadFrameHandle(ht,.KEY_FF, GetHandleId(ff)), icon, 0, true) 
    endmethod 
    static method changetexturex takes integer id, framehandle ff, string icon returns nothing 
        local framehandle f = LoadFrameHandle(ht,.KEY_FF, GetHandleId(ff)) 
        if f != null then 
            if GetLocalPlayer() == Player(id) then 
                call BlzFrameSetTexture(f, icon, 0, true) 
            endif 
        endif 
        set f = null 
    endmethod 
    static method button takes string path returns framehandle 
        local framehandle ff 
        local framehandle ff2 
        set ff2 = BlzCreateFrameByType("GLUEBUTTON", "FaceButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0) 
        set ff = BlzCreateFrameByType("BACKDROP", "FaceButtonIcon", ff2, "", 0) 
        call BlzFrameSetAllPoints(ff, ff2) 
        call BlzFrameSetTexture(ff, path, 0, true) 
        call SaveFrameHandle(ht,.KEY_FF, GetHandleId(ff2), ff) 
        set ff = null 
        return ff2 
    endmethod 
    static method buttonNoTexture takes nothing returns framehandle 
        local framehandle ff2 
        set ff2 = BlzCreateFrameByType("GLUEBUTTON", "FaceButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0) 
        return ff2 
    endmethod
    static method texture takes string path returns framehandle 
        local framehandle ff 
        local framehandle ff2 
        set ff2 = BlzCreateFrameByType("GLUECHECKBOX", "FaceButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0) 
        set ff = BlzCreateFrameByType("BACKDROP", "FaceButtonIcon", ff2, "", 0) 
        call BlzFrameSetAllPoints(ff, ff2) 
        call BlzFrameSetTexture(ff, path, 0, true) 
        call SaveFrameHandle(ht,.KEY_FF, GetHandleId(ff2), ff) 
        set ff = null 
        return ff2 
    endmethod 
    static method tooltip takes framehandle btn, real size, string desc returns framehandle 
        local framehandle bg = BlzCreateFrame("BoxedTextVH", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        local framehandle txt = BlzCreateFrameByType("TEXT", "MyScriptDialogButtonTooltip", bg, "", 0) 
        call BlzFrameSetLevel(bg, 9) 
        call BlzFrameSetSize(txt, size, 0) 
        call BlzFrameSetPoint(bg, FRAMEPOINT_BOTTOMLEFT, txt, FRAMEPOINT_BOTTOMLEFT, -0.01, -0.01) 
        call BlzFrameSetPoint(bg, FRAMEPOINT_TOPRIGHT, txt, FRAMEPOINT_TOPRIGHT, 0.01, 0.01) 
        call BlzFrameSetTooltip(btn, bg) 
        call BlzFrameSetPoint(txt, FRAMEPOINT_BOTTOM, btn, FRAMEPOINT_TOP, 0, 0.01) 
        call BlzFrameSetText(txt, desc) 
        call BlzFrameSetEnable(txt, false) 
        return txt 
    endmethod 
    static method click takes framehandle ff, code youfunc returns trigger 
        local trigger t = CreateTrigger() 
        call BlzTriggerRegisterFrameEvent(t, ff, FRAMEEVENT_CONTROL_CLICK) 
        call TriggerAddCondition(t, Condition(youfunc)) 
        return t 
    endmethod 
    static method enter takes framehandle ff, code youfunc returns trigger 
        local trigger t = CreateTrigger() 
        call BlzTriggerRegisterFrameEvent(t, ff, FRAMEEVENT_MOUSE_ENTER) 
        call TriggerAddCondition(t, Condition(youfunc)) 
        return t 
    endmethod 
    static method leave takes framehandle ff, code youfunc returns trigger 
        local trigger t = CreateTrigger() 
        call BlzTriggerRegisterFrameEvent(t, ff, FRAMEEVENT_MOUSE_LEAVE) 
        call TriggerAddCondition(t, Condition(youfunc)) 
        return t 
    endmethod 
    // units\NightElf\SpiritOfVengeance\Black128.blp //Black background    
    static method TOOLTIPBG takes framehandle fparent returns framehandle 
        local framehandle bg = BlzCreateFrameByType("BACKDROP", "BACKDROP" + I2S(.KEY_FF), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 1) 
        call BlzFrameSetVisible(bg, false) 
        call BlzFrameSetTexture(bg, "war3mapImported\\tooltipBG.blp", 0, true) 
        return bg 
    endmethod 
    static method TOOLTIPICON takes framehandle fparent, string path returns framehandle 
        local framehandle bg = BlzCreateFrameByType("BACKDROP", "BACKDROP" + I2S(.KEY_FF), fparent, "", 1) 
        call BlzFrameSetTexture(bg, path, 0, true) 
        return bg 
    endmethod 
    static method TOOLTIPTXT takes framehandle bg, real size, string desc returns framehandle 
        local framehandle txt = BlzCreateFrameByType("TEXT", "TEXT" + I2S(.KEY_FF), bg, "", 0) 
        call BlzFrameSetEnable(txt, false) 
        call BlzFrameSetSize(txt, size, 0) 
        call BlzFrameSetText(txt, desc) 
        return txt 
    endmethod 
    static method TOOLTIPTITLE takes framehandle bg, real size, string desc returns framehandle 
        local framehandle txt = BlzCreateFrameByType("TEXT", "TEXT" + I2S(.KEY_FF), bg, "", 0) 
        call BlzFrameSetEnable(txt, false) 
        call BlzFrameSetSize(txt, size, 0) 
        call BlzFrameSetText(txt, desc) 
        return txt 
    endmethod 
    static method TOOLTIPCOMBINE takes framehandle fparent, framehandle txt, framehandle bg returns nothing 
        call BlzFrameSetPoint(bg, FRAMEPOINT_BOTTOMLEFT, txt, FRAMEPOINT_BOTTOMLEFT, -0.01, -0.01) 
        call BlzFrameSetPoint(bg, FRAMEPOINT_TOPRIGHT, txt, FRAMEPOINT_TOPRIGHT, 0.01, 0.01) 
        call BlzFrameSetTooltip(fparent, bg) 
        call BlzFrameSetPoint(txt, FRAMEPOINT_TOP, fparent, FRAMEPOINT_BOTTOM, 0.010, -0.02) 
    endmethod 
endstruct