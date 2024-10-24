
struct EV_PLAYER_CHAT 
    static Randompool pool1 //if u have more pool then add more line variables or set it array    
    static method f_Checking takes nothing returns boolean 
        local string s = GetEventPlayerChatString() 
        local player p = GetTriggerPlayer() 
        local integer id = GetPlayerId(p)
        local string n = SubString(s, 0, 3) 
        local string i = SubString(s, 3, 5) 
        
        if SubString(s, 0, 1) == "-" and n == "-cl" then 
            if ENV_DEV then 
                call BJDebugMsg("Command: Clear Chat") 
                call BJDebugMsg("Type: " + n) 
            endif 
            if(GetLocalPlayer() == p) then 
                call ClearTextMessages() 
            endif 
        endif 
        if SubString(s, 0, 1) == "-" and n == "-rd" then 
            if ENV_DEV then 
                call BJDebugMsg("Command: Random Pool") 
                call BJDebugMsg("Type: " + n) 
            endif 
            call.pool1.random() 
        endif 
        if SubString(s, 0, 1) == "-" and n == "-ct" then 
            if ENV_DEV then 
                call BJDebugMsg("Command: Cheat Test") 
                call BJDebugMsg("Type: " + n) 
                call PLAYER.addgold(id,1000)
                call PLAYER.addlumber(id,1000)
                call PLAYER.addfoodcap(id,10)
            endif 
        endif 
        set p = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        set.pool1 = Randompool.create() 
        call.pool1.new_value(1, 50, 0, 0) 
        call.pool1.new_value(2, 30, 0, 5) 
        call.pool1.new_value(3, 20, 0, 2) 
        //This action everytime player chat, careful for use it.        
        call.add_chat("", true, function thistype.f_Checking) 
    endmethod 
    //You can use it for make more command in game instead my .add_chat("",true,function thistype.f_Checking)        
    static method add_chat takes string phase, boolean b, code actionfunc returns nothing 
        local integer index 
        local trigger trig = CreateTrigger() 
        set index = 0 
        loop 
            call TriggerRegisterPlayerChatEvent(trig, Player(index), phase, b) 
            set index = index + 1 
            exitwhen index == (MAX_PLAYER - 1)
        endloop 
        call TriggerAddAction(trig, actionfunc) 
        set trig = null 
    endmethod 
endstruct