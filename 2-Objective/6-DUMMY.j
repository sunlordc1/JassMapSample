
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
    static method new takes real x, real y, real duration, player p returns nothing 
        set bj_unit = CreateUnit(p,.dummy_id, x, y, bj_UNIT_FACING) 
        call UnitAddAbility(bj_unit, 'Avul') 
        call UnitAddAbility(bj_unit, 'Aloc') 
        call UnitApplyTimedLifeBJ(duration, 'BTLF', bj_unit) 
    endmethod 
    static method abi takes integer abi_id, integer level returns nothing 
        call UnitAddAbility(bj_unit, abi_id) 
        call BlzUnitHideAbility(bj_unit, abi_id, false) 
        call BlzEndUnitAbilityCooldown(bj_unit, abi_id) 
        call SetUnitAbilityLevel(bj_unit, abi_id, level) 
        call IssueImmediateOrder(bj_unit, "stop") 
        call BlzUnitHideAbility(bj_unit, abi_id, true) 
    endmethod 
    static method target takes string ordername, unit target returns nothing 
        call IssueTargetOrder(bj_unit, ordername, target) 
    endmethod 
    static method aoe takes string ordername, real x, real y returns nothing 
        local location loc = Location(x, y) 
        call IssuePointOrderLoc(bj_unit, ordername, loc) 
        call RemoveLocation(loc) 
    endmethod 
    static method notarget takes string ordername returns nothing 
        call IssueImmediateOrder(bj_unit, ordername) 
    endmethod 
    static method reset takes string ordername returns nothing 
        set bj_unit = null 
    endmethod 
endstruct 