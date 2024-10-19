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
    effect bj_effect = null // instead of bj_lastCreatedEffect   
    //Storage  
    hashtable ht = InitHashtable() // This is the hashtable you will use in most situations of the game.    
    //Timer  
    constant real TIME_SETUP_EVENT = 0.2 // The time to start setting up events for the game.   
    constant real P32 = 0.03125 // Explore this number; it truly has significance. 
    constant real P50 = 0.02 // Explore this number; it truly has significance. 
    //Utils  
    constant string SYSTEM_CHAT = "[SYSTEM]: |cffffcc00" 
    constant boolean ENV_DEV = true // Are u on a testing mode ?

    //Setting Game 
    constant boolean CREEP_SLEEP = false
    constant boolean LOCK_RESOURCE_TRADING = true
    constant boolean SHARED_ADVANCED_CONTROL = false
    constant real GAME_PRELOAD_TIME = 1.00
    constant real GAME_STATUS_TIME = 2.00
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

// You want to notify a specific player in the form of a system message. Use this:  
function SystemChat takes player ForPlayer, string message returns nothing 
    local string msg = ""
    set msg = SYSTEM_CHAT + message + "|r" 
    if(GetLocalPlayer() == ForPlayer) then 
        // call ClearTextMessages()         
        call DisplayTimedTextToPlayer(ForPlayer, 0, 0, 2.00, message) 
    endif 
endfunction 

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

    static method IsPlayerOnline takes player p returns boolean 
        return GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(p) == MAP_CONTROL_USER 
    endmethod 
    static method AddGold takes integer id , integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod
    static method AddLumber takes integer id , integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_GOLD) 
    endmethod
    static method AddFoodCap takes integer id , integer value returns nothing 
        call AdjustPlayerStateBJ(value, Player(id), PLAYER_STATE_RESOURCE_FOOD_CAP) 
    endmethod
endstruct

//--- Content from folder: ./3-Skill/1-SampleSkill.j ---


//--- Content from folder: ./4-Event/1 - Unit - BeginConstruction.j ---
struct EVENT_BEGIN_STRUCTION 
    static method Checking takes nothing returns boolean 
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
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_CONSTRUCT_START) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 


//--- Content from folder: ./4-Event/2 - Unit - LoseAnItem.j ---
struct EVENT_UNIT_DROP_ITEM 
    static method Checking takes nothing returns boolean 
        local unit caster = GetTriggerUnit() 
        local integer dropitem_id = GetItemTypeId(GetManipulatedItem()) 
        local item dropitem = GetManipulatedItem() 
        local integer pid = GetPlayerId(GetTriggerPlayer()) 
        local integer charge = GetItemCharges(dropitem) 

        //commonly used sample trick :When you lose a fake item (power-up) and use it to increase resources 
        //that are not available in the game's UI or to craft equipment.
        if dropitem_id == '0000' and false then 
            call SystemChat(Player(pid), "=>[Loot] " + GetItemName(dropitem) + " x" + I2S(charge)) 
            return false
        endif
        //===========================================================================
        
        set dropitem = null 
        set caster = null 
        return false 
    endmethod 
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 

endstruct

//--- Content from folder: ./4-Event/3 - Unit - TargetOrder.j ---

struct EVENT_TARGET_ORDER 
    static method Checking takes nothing returns nothing 
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
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 



//--- Content from folder: ./4-Event/4 - Unit - Die.j ---


struct EVENT_UNIT_DEATH 
    static method Checking takes nothing returns boolean 
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
 
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct

//--- Content from folder: ./4-Event/5 - Unit - BeginCastingSpell.j ---

struct EVENT_CASTING_SPELL 
    static method Checking takes nothing returns boolean 
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
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_CAST) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 

endstruct 


//--- Content from folder: ./4-Event/6 - Unit - StartEffectSpell.j ---
struct EVENT_START_SPELL_EFFECT 
    static method Checking takes nothing returns boolean 
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
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 



//--- Content from folder: ./4-Event/7 - Hero - LearnSpell.j ---
struct EVENT_LEARN_SKILL 
    static method Checking takes nothing returns boolean 
        local unit caster = GetLearningUnit() 
        local integer id = GetLearnedSkill()  //Ability ID learning spell
        local integer uid = GetUnitTypeId(caster) 
   
        set caster = null 
        return false 
    endmethod 

    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_SKILL) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 

//--- Content from folder: ./4-Event/8 - Unit - SoldUnit.j ---

struct EVENT_UNIT_SELL 
    static method Checking takes nothing returns boolean 
        local unit u = GetSoldUnit() 
        local unit caster = GetTriggerUnit() 
        local integer pid = GetPlayerId(GetOwningPlayer(GetSoldUnit())) 

        set u = null 
        set caster = null 
        return false 
    endmethod 
    static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SELL) 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 


//--- Content from folder: ./4-Event/9 - Player- Leave.j ---
struct EVENT_PLAYER_LEAVES 
    static method Checking takes nothing returns boolean 
        local player p = GetTriggerPlayer() 
        set PLAYER.IsDisconect[GetPID(p)] = true 


        set p = null 
        return false 
    endmethod 
    private static method SetupEvent takes nothing returns nothing 
        local trigger t = CreateTrigger() // Create a trigger                                                                                                                          
        local integer n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            call TriggerRegisterPlayerEventLeave(t, Player(n)) 
            set n = n + 1 
        endloop 
        call TriggerAddAction(t, function thistype.Checking) 
    endmethod 
endstruct 

//--- Content from folder: ./4-Event/999 - Event Init.j ---
struct REGISTER_EVENT 
    private static method SetupAllEvent takes nothing returns nothing 
        //Comment if u don't use the event 
        call EVENT_BEGIN_STRUCTION.SetupEvent()
        call EVENT_UNIT_DROP_ITEM.SetupEvent()
        call EVENT_TARGET_ORDER.SetupEvent()
        call EVENT_UNIT_DEATH.SetupEvent()
        call EVENT_CASTING_SPELL.SetupEvent()
        call EVENT_START_SPELL_EFFECT.SetupEvent()
        call EVENT_LEARN_SKILL.SetupEvent()
        call EVENT_UNIT_SELL.SetupEvent()
        
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

    private static method GameStart takes nothing returns nothing 

        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method GameSetting takes nothing returns nothing 
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, LOCK_RESOURCE_TRADING) 
        call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, SHARED_ADVANCED_CONTROL) 
        call EnableCreepSleepBJ(CREEP_SLEEP) 

        call DestroyTimer(GetExpiredTimer()) 
      
    endmethod 
    private static method GameStatus takes nothing returns nothing 
        local integer n = 0 
        // Check player is online in game
        set n = 0 
        loop 
            exitwhen n > bj_MAX_PLAYER_SLOTS 
            if PLAYER.IsPlayerOnline(Player(n)) then 
                set PLAYER.IsDisconect[n] = false 
            else 
                set PLAYER.IsDisconect[n] = true 
            endif 
            set n = n + 1 
        endloop 
        call DestroyTimer(GetExpiredTimer()) 
         
    endmethod 
    private static method PreloadMap takes nothing returns nothing 
        call Preload_Ability('Amls') // Preload skill             
        call Preload_Unit('uloc') // Preload unit            
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 

    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), GAME_PRELOAD_TIME, false, function thistype.PreloadMap) 
        call TimerStart(CreateTimer(), GAME_STATUS_TIME, false, function thistype.GameStatus) 
    endmethod 
endstruct 

