
//Use :                               
// Order :                           
//==> call DUMMY.target("thunderbolt",target, ability_id , level_of_ability) [Search order name of spell u add]                            
// But it's only work for use make some effect to enemy (please select target allow in skill is Air,Ground )  
//when you use freedom dummy then u need use newx, it's will return new dummy  
struct Dummy 
    static integer dummy_id = 'e000' //Set your id dummy                                 
    static unit load = null 
    static method new takes nothing returns nothing 
        set.load = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),.dummy_id, 0, 0, 0) 
        call UnitAddAbility(.load, 'Avul') 
        call UnitAddAbility(.load, 'Aloc') 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 
    static method newx takes integer pid returns unit 
        set bj_unit = CreateUnit(Player(pid),.dummy_id, 0, 0, 0) 
        call UnitAddAbility(bj_unit, 'Avul') 
        call UnitAddAbility(bj_unit, 'Aloc') 
        return bj_unit 
    endmethod 
    static method target takes string ordername, unit dummy, unit u, integer spell_id, integer level returns nothing 
        call SetUnitX(dummy, GetUnitX(u)) 
        call SetUnitY(dummy, GetUnitY(u)) 
        call UnitAddAbility(dummy, spell_id) 
        call SetUnitAbilityLevel(dummy, spell_id, level) 
        call IssueTargetOrder(dummy, ordername, u) 
        call UnitRemoveAbility(dummy, spell_id) 
    endmethod 
    static method point takes string ordername, unit dummy, real x, real y, integer level, integer spell_id returns nothing 
        call SetUnitX(dummy, x) 
        call SetUnitY(dummy, y) 
        call UnitAddAbility(dummy, spell_id) 
        call SetUnitAbilityLevel(dummy, spell_id, level) 
        call MoveLocation(bj_loc, x, y) 
        call IssuePointOrderLoc(dummy, ordername, bj_loc) 
        call UnitRemoveAbility(dummy, spell_id) 
    endmethod 
    static method notarget takes string ordername, unit dummy, real x, real y, integer level, integer spell_id returns nothing 
        call SetUnitX(dummy, x) 
        call SetUnitY(dummy, y) 
        call UnitAddAbility(dummy, spell_id) 
        call SetUnitAbilityLevel(dummy, spell_id, level) 
        call IssueImmediateOrder(bj_unit, ordername) 
        call UnitRemoveAbility(dummy, spell_id) 
    endmethod 
    private static method onInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), 1, false, function thistype.new) 
    endmethod 
endstruct 