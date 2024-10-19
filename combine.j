//--- Content from folder: ./1-Variables Library System Func/1-GlobalsVariables.j ---

//Constant : A constant value does not change, and you use it to set fixed parameters in the game. 
globals 
    //We will define bj_ as a type of variable that is used and processed at a specific moment, 
    // is always redefined when it starts being used, and is assigned a null value when finished. 
    //Number  
    integer bj_int = 0 // Typically used for a single loop or assigning a random value. 
    real bj_real = 0.00 //Typically used for a single loop or assigning a random value. 
    //Objective  
    item bj_item = null // instead of bj_lastCreatedItem   
    unit bj_unit = null // instead of bj_lastCreatedUnit   
    effect bj_eff = null // instead of bj_lastCreatedEffect   
    //Storage  
    hashtable ht = InitHashtable() // This is the hashtable you will use in most situations of the game.    
    //Timer  
    constant real TIME_SETUP_EVENT = 0.2 // The time to start setting up events for the game.   
    constant real P32 = 0.03125 // Explore this number; it truly has significance. 
    constant real P64 = 0.03125*2 // Explore this number; it truly has significance. 
    //Utils  
    constant string SYSTEM_CHAT = "[SYSTEM]: |cffffcc00" 
    constant boolean ENV_DEV = true // Are u on a testing mode ?

    //Setting Game 
    constant boolean CREEP_SLEEP = false
    constant boolean LOCK_RESOURCE_TRADING = true
    constant boolean SHARED_ADVANCED_CONTROL = false
    constant real GAME_PRELOAD_TIME = 0.01
    constant real GAME_STATUS_TIME = 1.00
    constant real GAME_SETTING_TIME = 3.00
    constant real GAME_START_TIME = 5.00

    
endglobals 



//--- Content from folder: ./1-Variables Library System Func/2-Library.j ---


//--- Content from folder: ./1-Variables Library System Func/2-Runtime.j ---
//I will use this for the skill writing section, so don’t worry about it if you don’t want to rewrite the library.
struct runtime
    static method new takes integer i, real timeout, boolean periodic, code func returns timer
        local timer t = CreateTimer()
        local integer id = GetHandleId(t)
        call SaveInteger(ht, id, 0, i)
        call SaveInteger(ht, id, 2, 0) 
        call SaveReal(ht, id, 1, timeout)
        call TimerStart(t, timeout, periodic, func)
        return t
    endmethod
    static method tick takes nothing returns integer 
        return LoadInteger(ht, GetHandleId(GetExpiredTimer()), 2)
    endmethod
    static method get takes nothing returns integer 
        local integer id = GetHandleId(GetExpiredTimer())
        call SaveInteger(ht, id, 2, LoadInteger(ht, id, 2) + 1)
        return LoadInteger(ht, id, 0)
    endmethod
    static method count takes nothing returns real 
        local integer id = GetHandleId(GetExpiredTimer())
        return I2R(LoadInteger(ht, id, 2)) * LoadReal(ht, id, 1)
    endmethod
    static method end takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call PauseTimer(t)
        call FlushChildHashtable(ht, GetHandleId(t))
        call DestroyTimer(t)
        set t = null
    endmethod
    static method endx takes timer t returns nothing
        call PauseTimer(t)
        call FlushChildHashtable(ht, GetHandleId(t))
        call DestroyTimer(t)
        set t = null
    endmethod
endstruct

//--- Content from folder: ./1-Variables Library System Func/3-Utils.j ---

///======= Preload Function   
// === When creating a new ability or unit that hasn't been used in the map,he game may experience a slight lag.   
// === Therefore, you should initialize them at the start of the game to ensure a smooth gameplay experience.  

function Preload_Unit takes integer id returns nothing 
    call RemoveUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), id, 0, 0, 270)) 
endfunction 
   
function Preload_Item takes integer id returns nothing 
    call RemoveItem(CreateItem(id, 0, 0)) 
endfunction 
   
function Preload_Ability takes integer id returns nothing 
    local unit u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nzin', 0, 0, 270) 
    call UnitAddAbility(u, id) 
    call UnitRemoveAbility(u, id) 
    call RemoveUnit(u) 
    set u = null 
endfunction 
   
function Preload_Sound takes unit u, string path returns nothing 
    local sound s = CreateSound(path, false, true, true, 12700, 12700, "") 
    call SetSoundVolume(s, 100) 
    call AttachSoundToUnit(s, u) 
    call StartSound(s) 
    call KillSoundWhenDone(s) 
endfunction 
// Charge Item   
function RemoveChargeItem takes item i, integer req returns nothing 
    call SetItemCharges(i, GetItemCharges(i) -req) 
    if GetItemCharges(i) <= 0 then 
        call RemoveItem(i) 
    endif 
endfunction 
//====================================================================================  
///======= Ultils   



//====================================================================================
///======Player 
function GetPID takes player whichPlayer returns integer
    return GetPlayerId(whichPlayer)
endfunction
   
function GetUID takes unit u returns integer
    return GetPlayerId(GetOwningPlayer(u))
endfunction

//--- Content from folder: ./2-Objective/1-PLAYER.j ---
struct PLAYER 
    static boolean array IsDisconect 


    //============PLAYER STATUS ==========
    static method IsPlayerOnline takes player p returns boolean 
        return GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(p) == MAP_CONTROL_USER 
    endmethod 
    //=============GOLD=================== 
    static method GetGold takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod 
    static method SetGold takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_GOLD, value) 
    endmethod 
    static method AddGold takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod 
    //=============LUMBER=================== 
    static method GetLumber takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod 
    static method SetLumber takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_LUMBER, value) 
    endmethod 
    static method AddLumber takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_LUMBER) 
    endmethod 
    //=============FOODCAP=================== 
    static method GetFoodCap takes integer id returns integer 
        return GetPlayerState(Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP) 
    endmethod 
    static method SetFoodCap takes integer id, integer value returns nothing 
        call SetPlayerStateBJ(Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP, value) 
    endmethod 
    static method AddFoodCap takes integer id, integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP) 
    endmethod 
    //=============FLAG=================== 
    static method BountyFlag takes integer id, boolean flag returns nothing 
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
    static method SystemChat takes player ForPlayer, string message returns nothing 
        local string msg = "" 
        set msg = SYSTEM_CHAT + message + "|r" 
        if(GetLocalPlayer() == ForPlayer) then 
            // call ClearTextMessages()                 
            call DisplayTimedTextToPlayer(ForPlayer, 0, 0, 2.00, message) 
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

//--- Content from folder: ./2-Objective/2-DESTRUCTABLE.j ---
struct DESTRUCTABLE //Destructable  
    static method OpenGate takes destructable d returns nothing 
        call KillDestructable(d) 
        call SetDestructableAnimation(d, "death alternate") 
        set d = null 
    endmethod 
    
    static method DestroyGate takes destructable d returns nothing 
        call KillDestructable(d) 
        call SetDestructableAnimation(d, "death") 
        set d = null 
    endmethod 
    
    static method CloseGate takes destructable d returns nothing 
        call DestructableRestoreLife(d, GetDestructableMaxLife(d), true) 
        call SetDestructableAnimation(d, "stand") 
        set d = null 
    endmethod 
endstruct 


//--- Content from folder: ./3-Skill/1-SampleSkill.j ---


//--- Content from folder: ./4-Event/1 - Unit - BeginConstruction.j ---
struct EVENT_BEGIN_STRUCTION 
    static method f_Checking takes nothing returns boolean 
        local unit builder = GetTriggerUnit() 
        local unit constructing = GetConstructingStructure() 
        local integer sid = GetUnitTypeId(constructing) 
        local integer pid = GetPlayerId(GetOwningPlayer(constructing)) 


        // commonly used sample trick : Cancel a build under construction with conditions  
        if sid == '0000' and false then //Make your condition  
            call TriggerSleepAction(0.01) //need for the trick  
            call IssueImmediateOrderById(constructing, 851976) //order cancel build  
            return false 
        endif 
        //===============================================================================  

        set builder = null 
        set constructing = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_CONSTRUCT_START) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 


//--- Content from folder: ./4-Event/2a - Unit - AcquiresAnItem.j ---
//
struct EVENT_UNIT_ACQUIRES_ITEM 
    static method f_Checking takes nothing returns boolean 
        local item acquire_item = GetManipulatedItem() 
        local integer ItemID = GetItemTypeId(acquire_item) 
        local unit u = GetTriggerUnit() 
        local integer pid = GetPlayerId(GetOwningPlayer(u)) 
        local integer charge = GetItemCharges(acquire_item) 

  
        
        set acquire_item = null 
        set u = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 

endstruct

//--- Content from folder: ./4-Event/2b - Unit - LoseAnItem.j ---
struct EVENT_UNIT_DROP_ITEM 
    static method f_Checking takes nothing returns boolean 
        local unit u = GetTriggerUnit() 
        local integer dropitem_id = GetItemTypeId(GetManipulatedItem()) 
        local item dropitem = GetManipulatedItem() 
        local integer pid = GetPlayerId(GetOwningPlayer(u)) 
        local integer charge = GetItemCharges(dropitem) 

        //commonly used sample trick :When you lose a fake item (power-up) and use it to increase resources 
        //that are not available in the game's UI or to craft equipment.
        if dropitem_id == '0000' and false then 
            call PLAYER.SystemChat(Player(pid), "=>[Loot] " + GetItemName(dropitem) + " x" + I2S(charge)) 
            return false
        endif
        //===========================================================================
        
        set dropitem = null 
        set u = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 

endstruct

//--- Content from folder: ./4-Event/3a - Unit - TargetOrder.j ---

struct EVENT_TARGET_ORDER 
    static method f_Checking takes nothing returns nothing 
        local unit u = GetTriggerUnit() 
        local item i = GetOrderTargetItem() 
        local unit e = GetOrderTargetUnit() 
        local integer w = GetUnitTypeId(e) 
        local integer d = GetUnitTypeId(u) 
        local integer id = GetUID(u) 
        local integer orderid = GetIssuedOrderId() 
        //commonly used sample trick : Use item target spell 
        if i != null then 
            if orderid >= 852008 and orderid <= 852013 then 
                if ENV_DEV then 
                    call BJDebugMsg(I2S(GetIssuedOrderId())) 
                    call BJDebugMsg(GetItemName(i)) 
                endif 
            endif 
        endif 

        //commonly used sample trick :   
        if GetIssuedOrderId() == 851971 then 
              
        endif 
          
        set u = null 
        set i = null 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 



//--- Content from folder: ./4-Event/3b - Unit - TargetPoint.j ---
struct EVENT_POINT_ORDER 
    static method f_Checking takes nothing returns nothing 
        local unit u = GetTriggerUnit() 
        local real x = GetOrderPointX() 
        local real y = GetOrderPointY() 

   
          
        set u = null 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 



//--- Content from folder: ./4-Event/3c - Unit - NoTargetOrder.j ---
struct EVENT_NO_TARGET_ORDER 
    static method f_Checking takes nothing returns nothing 
        local unit u = GetTriggerUnit() 
          
        set u = null 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_ORDER) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 



//--- Content from folder: ./4-Event/4 - Unit - Die.j ---


struct EVENT_UNIT_DEATH 
    static method f_Checking takes nothing returns boolean 
        local unit killer = GetKillingUnit() 
        local unit dying = GetDyingUnit() 
        local integer hdid = GetHandleId(dying) 
        local integer hkid = GetHandleId(killer) 
        local integer did = GetUnitTypeId(dying) 
        local integer kid = GetUnitTypeId(killer) 
        local integer pdid = GetUID(dying) //Id player of dying  
        local integer pkid = GetUID(killer) //Id player of killer  



        set killer = null 
        set dying = null 
        return false 
    endmethod 
 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct

//--- Content from folder: ./4-Event/5a - Unit - BeginCastingSpell.j ---

struct EVENT_CASTING_SPELL 
    static method f_Checking takes nothing returns boolean 
        local unit caster = GetTriggerUnit() 
        local integer idc = GetUnitTypeId(caster) 
        local unit target = GetSpellTargetUnit() 
        local integer spell_id = GetSpellAbilityId() 
        local item it = GetSpellTargetItem() 
        local integer pid = GetUID(caster) 
        local real targetX = GetSpellTargetX() 
        local real targetY = GetSpellTargetY() 

                    
        set target = null 
        set caster = null 
        set it = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_CAST) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 

endstruct 


//--- Content from folder: ./4-Event/5b - Unit - StartEffectSpell.j ---
struct EVENT_START_SPELL_EFFECT 
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



//--- Content from folder: ./4-Event/6 - Hero - LearnSpell.j ---
struct EVENT_LEARN_SKILL 
    static method f_Checking takes nothing returns boolean 
        local unit caster = GetLearningUnit() 
        local integer id = GetLearnedSkill()  //Ability ID learning spell
        local integer uid = GetUnitTypeId(caster) 
   
        set caster = null 
        return false 
    endmethod 

    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_SKILL) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 

//--- Content from folder: ./4-Event/7 - Unit - SoldUnit.j ---

struct EVENT_UNIT_SELL 
    static method f_Checking takes nothing returns boolean 
        local unit u = GetSoldUnit() 
        local unit caster = GetTriggerUnit() 
        local integer pid = GetPlayerId(GetOwningPlayer(GetSoldUnit())) 

        set u = null 
        set caster = null 
        return false 
    endmethod 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SELL) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 


//--- Content from folder: ./4-Event/8 - Player- Leave.j ---
struct EVENT_PLAYER_LEAVES 
    static method f_Checking takes nothing returns boolean 
        local player p = GetTriggerPlayer() 
        
        set PLAYER.IsDisconect[GetPID(p)] = true 
        set GAME.CountPlayer = GAME.CountPlayer - 1 


        set p = null 
        return false 
    endmethod 
    private static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() // Create a trigger                                                                                                                          
        local integer n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            call TriggerRegisterPlayerEventLeave(t, Player(n)) 
            set n = n + 1 
        endloop 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct 

//--- Content from folder: ./4-Event/9 - Unit - Attacked.j ---



struct EVENT_UNIT_ATTACK
    static method f_Checking takes nothing returns boolean 
        local unit attacker = GetAttacker() 
        local unit attacked = GetTriggerUnit() 
        //Trick: Someone use it for stop attack to ally



        set attacker = null 
        set attacked = null 
        return false 
    endmethod 
 
    static method f_SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED) 
        call TriggerAddAction(t, function thistype.f_Checking) 
    endmethod 
endstruct

//--- Content from folder: ./4-Event/999 - Event Init.j ---
struct REGISTER_EVENT 
    private static method SetupAllEvent takes nothing returns nothing 
        //Comment if u don't use the event 
        call EVENT_BEGIN_STRUCTION.f_SetupEvent()
        // ITEM
        call EVENT_UNIT_ACQUIRES_ITEM.f_SetupEvent()
        call EVENT_UNIT_DROP_ITEM.f_SetupEvent()
        // ORDER
        call EVENT_TARGET_ORDER.f_SetupEvent()
        call EVENT_POINT_ORDER.f_SetupEvent()
        call EVENT_NO_TARGET_ORDER.f_SetupEvent()
        // SPELL
        call EVENT_CASTING_SPELL.f_SetupEvent()
        call EVENT_START_SPELL_EFFECT.f_SetupEvent()
        call EVENT_LEARN_SKILL.f_SetupEvent()
        // MISC
        call EVENT_UNIT_DEATH.f_SetupEvent()
        call EVENT_UNIT_ATTACK.f_SetupEvent()
        call EVENT_UNIT_SELL.f_SetupEvent()
        call DestroyTimer(GetExpiredTimer()) 
    endmethod
    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), TIME_SETUP_EVENT, false, function thistype.SetupAllEvent) 
    endmethod 
endstruct 


//--- Content from folder: ./5-Features/1-UI.j ---


//--- Content from folder: ./6-Timers/1-Interval.j ---


//--- Content from individual file: ./GAME.j ---
struct GAME 
    static boolean IsSinglePlay = false 
    static integer CountPlayer = 0 
    private static method GameStart takes nothing returns nothing 
        call FogMaskEnable(false) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Game Start ...")
        endif 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method GameSetting takes nothing returns nothing 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Setting Game ...")
        endif 
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, LOCK_RESOURCE_TRADING) 
        call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, SHARED_ADVANCED_CONTROL) 
        call EnableCreepSleepBJ(CREEP_SLEEP) 

 

        call DestroyTimer(GetExpiredTimer()) 
      
    endmethod 
    private static method GameStatus takes nothing returns nothing 
        local integer n = 0 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"f_Checking Status ...")
        endif 
        // Check player is online in game  
        set n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            if PLAYER.IsPlayerOnline(Player(n)) then 
                set PLAYER.IsDisconect[n] = false 
                set GAME.CountPlayer = GAME.CountPlayer + 1 
            else 
                set PLAYER.IsDisconect[n] = true 
            endif 
            set n = n + 1 
        endloop 
        call DestroyTimer(GetExpiredTimer()) 
         
    endmethod 
    private static method PreloadMap takes nothing returns nothing 
        call FogMaskEnable(true) 
        call PanCameraToTimed(0, 0, 0) 
        if ENV_DEV then 
            call DisplayTextToForce(GetPlayersAll(),"Preload ...")
        endif 
       
        call Preload_Ability('Amls') // Preload skill               
        call Preload_Unit('uloc') // Preload unit              
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), GAME_PRELOAD_TIME, false, function thistype.PreloadMap) 
        call TimerStart(CreateTimer(), GAME_STATUS_TIME, false, function thistype.GameStatus) 
        call TimerStart(CreateTimer(), GAME_SETTING_TIME, false, function thistype.GameSetting) 
        call TimerStart(CreateTimer(), GAME_START_TIME, false, function thistype.GameStart) 
    endmethod 
endstruct 


