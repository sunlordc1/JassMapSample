struct PLAYER 
    static boolean array IsDisconect 


    //============PLAYER STATUS ==========
    static method IsPlayerOnline takes player p returns boolean 
        return GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(p) == MAP_CONTROL_USER 
    endmethod 
    //=============GOLD=================== 
    static method gold takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod 
    static method setgold takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_GOLD, value) 
    endmethod 
    static method addgold takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod 
    //=============LUMBER=================== 
    static method lumber takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_LUMBER) 
    endmethod 
    static method setlumber takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_LUMBER, value) 
    endmethod 
    static method addlumber takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_LUMBER) 
    endmethod 
    //=============FOODCAP=================== 
    static method food takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_FOOD_USED) 
    endmethod 
    static method foodcap takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP) 
    endmethod 
    static method setfoodcap takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP, value) 
    endmethod 
    static method addfoodcap takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP) 
    endmethod 
    //=============FLAG=================== 
    static method bountyflag takes integer id, boolean flag returns nothing 
        call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, flag, Player(id)) 
    endmethod 
    //=============RESEARCH=================== 
    static method SetResearchLevel takes integer tech_id, integer level, integer pid returns nothing 
        call SetPlayerTechResearchedSwap(tech_id, level, Player(pid)) 
    endmethod 
    //=============ALLIANCE=================== 
    static method SetAllyWith takes integer pid, integer to_pid returns nothing 
        call SetPlayerAllianceStateBJ(Player(pid), Player(to_pid), bj_ALLIANCE_ALLIED_VISION) 
    endmethod 
    static method SetEnemyWith takes integer pid, integer to_pid, boolean share_vision returns nothing 
        if share_vision then 
            call SetPlayerAllianceStateBJ(Player(pid), Player(to_pid), bj_ALLIANCE_UNALLIED_VISION) 
        else 
            call SetPlayerAllianceStateBJ(Player(pid), Player(to_pid), bj_ALLIANCE_UNALLIED) 
        endif 
    endmethod 
    static method SetNeutralWith takes integer pid, integer to_pid, boolean share_vision returns nothing 
        if share_vision then 
            call SetPlayerAllianceStateBJ(Player(pid), Player(to_pid), bj_ALLIANCE_NEUTRAL_VISION) 
        else 
            call SetPlayerAllianceStateBJ(Player(pid), Player(to_pid), bj_ALLIANCE_NEUTRAL) 
        endif 
    endmethod 
    //=============CHAT=================== 
    // You want to notify a specific player in the form of a system message. Use this:          
    static method systemchat takes player ForPlayer, string message returns nothing 
        local string msg = "" 
        set msg = SYSTEM_CHAT + message + "|r" 
        if(GetLocalPlayer() == ForPlayer) then 
            // call ClearTextMessages()                 
            call DisplayTimedTextToPlayer(ForPlayer, 0, 0, 2.00, message) 
        endif 
    endmethod 
    static method questmsgplayer takes player p, string msg, integer msgtype returns nothing 
        if GetLocalPlayer() == p then 
            call.questmsg(GetLocalPlayer(), msg, msgtype) 
        endif 
    endmethod 

    static method questmsgforce takes force f, string msg, integer msgtype returns nothing 
        if(IsPlayerInForce(GetLocalPlayer(), f)) then 
            call.questmsg(GetLocalPlayer(), msg, msgtype) 
        endif 
    endmethod 
    static method questmsg takes player p, string message, integer msgtype returns nothing 
        if(msgtype == Questmsg.DISCOVERED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUEST, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUEST, message) 
            call StartSound(bj_questDiscoveredSound) 
            call FlashQuestDialogButton() 
        elseif(msgtype == Questmsg.UPDATED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTUPDATE, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTUPDATE, message) 
            call StartSound(bj_questUpdatedSound) 
            call FlashQuestDialogButton() 
        elseif(msgtype == Questmsg.COMPLETED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTDONE, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTDONE, message) 
            call StartSound(bj_questCompletedSound) 
            call FlashQuestDialogButton() 
        elseif(msgtype == Questmsg.FAILED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTFAILED, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTFAILED, message) 
            call StartSound(bj_questFailedSound) 
            call FlashQuestDialogButton() 
        elseif(msgtype == Questmsg.REQUIREMENT) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_QUESTREQUIREMENT, message) 
        elseif(msgtype == Questmsg.MISSIONFAILED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_MISSIONFAILED, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_MISSIONFAILED, message) 
            call StartSound(bj_questFailedSound) 
        elseif(msgtype == Questmsg.HINT) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_HINT, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_HINT, message) 
            call StartSound(bj_questHintSound) 
        elseif(msgtype == Questmsg.ALWAYSHINT) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_ALWAYSHINT, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_ALWAYSHINT, message) 
            call StartSound(bj_questHintSound) 
        elseif(msgtype == Questmsg.SECRET) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_SECRET, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_SECRET, message) 
            call StartSound(bj_questSecretSound) 
        elseif(msgtype == Questmsg.UNITACQUIRED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_UNITACQUIRED, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_UNITACQUIRED, message) 
            call StartSound(bj_questHintSound) 
        elseif(msgtype == Questmsg.UNITAVAILABLE) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_UNITAVAILABLE, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_UNITAVAILABLE, message) 
            call StartSound(bj_questHintSound) 
        elseif(msgtype == Questmsg.ITEMACQUIRED) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_ITEMACQUIRED, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_ITEMACQUIRED, message) 
            call StartSound(bj_questItemAcquiredSound) 
        elseif(msgtype == Questmsg.WARNING) then 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_WARNING, " ") 
            call DisplayTimedTextToPlayer(p, 0, 0, bj_TEXT_DELAY_WARNING, message) 
            call StartSound(bj_questWarningSound) 
        else 
            // Unrecognized message type - ignore the request.                                      
        endif 
    endmethod 
    //=============MISC=================== 
    //Force player use a key in board
    static method ForceUIKeyBJ takes player whichPlayer, string key, unit u returns nothing 
        if(GetLocalPlayer() == whichPlayer) then 
            // Use only local code (no net traffic) within this block to avoid desyncs.        
            call ClearSelection() 
            call SelectUnit(u, true) 
            call ForceUIKey(key) 
        endif 
    endmethod 
    //Ping minimap     
    static method PingMinimapExe takes player p, real x, real y, real duration, integer red, integer green, integer blue, boolean extraEffects returns nothing 
        if IsPlayerAlly(GetLocalPlayer(), p) then 
            call PingMinimapEx(x, y, duration, red, green, blue, extraEffects) 
        endif 
        set p = null 
    endmethod 
endstruct