
//Use :                           
// Make new dummy :                       
//==> call DUMMY.new(x,y,duration,p )                          

// Add Ability need cast and set level it :                        
//==> call DUMMY.abi(abi_id,level)                         

// Order :                       
//==> call DUMMY.target("thunderbolt",target) [Search order name of spell u add]                        

// Reset variable after order :                       
//==>  call DUMMY.reset()                       
struct Dummy 
    static integer dummy_id = 'e000' //Set your id dummy                             
    static unit load = null 
    // static method new takes real x, real y, real dur, player p returns nothing  
    //     set bj_unit = CreateUnit(p, .dummy_id, x, y, bj_UNIT_FACING)  
    //     call UnitAddAbility(bj_unit, 'Avul')  
    //     call UnitAddAbility(bj_unit, 'Aloc')  
    //     call UnitApplyTimedLifeBJ(dur, 'BTLF', bj_unit)  
    // endmethod  
    // static method abi takes integer abi_id, integer level returns nothing  
    //     call UnitAddAbility(bj_unit, abi_id)  
    //     call BlzUnitHideAbility(bj_unit, abi_id, false)  
    //     call BlzEndUnitAbilityCooldown(bj_unit, abi_id)  
    //     call SetUnitAbilityLevel(bj_unit, abi_id, level)  
    //     call IssueImmediateOrder(bj_unit, "stop")  
    //     call BlzUnitHideAbility(bj_unit, abi_id, true)  
    // endmethod  
    // static method target takes string ordername, unit target returns nothing  
    //     call IssueTargetOrder(bj_unit, ordername, target)  
    // endmethod  
    // static method point takes string ordername, real x, real y returns nothing  
    //     call MoveLocation(bj_loc, x, y)  
    //     call IssuePointOrderLoc(bj_unit, ordername, bj_loc)  
    // endmethod  
    // static method notarget takes string ordername returns nothing  
    //     call IssueImmediateOrder(bj_unit, ordername)  
    // endmethod  
    // static method reset takes nothing returns nothing  
    //     set bj_unit = null  
    // endmethod  
    static method new takes nothing returns nothing 
        set.load = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),.dummy_id, 0, 0, 0) 
        call UnitAddAbility(.load, 'Avul') 
        call UnitAddAbility(.load, 'Aloc') 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 
    static method target takes string ordername, unit u, integer spell_id, integer level returns nothing 
        call SetUnitX(.load, GetUnitX(u)) 
        call SetUnitY(.load, GetUnitY(u)) 
        call BJDebugMsg(GetUnitName(.load) + "[]" + R2S(GetUnitX(.load)) + "[]" + R2S(GetUnitY(.load))) 

        call UnitAddAbility(.load, spell_id) 
        call SetUnitAbilityLevel(.load, spell_id, level) 

        call IssueTargetOrder(.load, ordername, u) 
        
        call UnitRemoveAbility(.load, spell_id) 
    endmethod 
    static method point takes string ordername, real x, real y, integer level, integer spell_id returns nothing 
        call SetUnitX(.load, x) 
        call SetUnitY(.load, y) 
        call UnitAddAbility(.load, spell_id) 
        call SetUnitAbilityLevel(.load, spell_id, level) 
        call MoveLocation(bj_loc, x, y) 

        call IssuePointOrderLoc(.load, ordername, bj_loc) 

        call UnitRemoveAbility(.load, spell_id) 
    endmethod 
    static method notarget takes string ordername, real x, real y, integer level, integer spell_id returns nothing 
        call SetUnitX(.load, x) 
        call SetUnitY(.load, y) 
        call UnitAddAbility(.load, spell_id) 
        call SetUnitAbilityLevel(.load, spell_id, level) 

        call IssueImmediateOrder(bj_unit, ordername) 

        call UnitRemoveAbility(.load, spell_id) 
    endmethod 
    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), 1, false, function thistype.new) 
    endmethod 
endstruct 