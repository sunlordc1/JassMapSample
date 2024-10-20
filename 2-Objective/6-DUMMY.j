
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
    static method new takes nothing returns nothing 
        set.load = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),.dummy_id, 0, 0, 0) 
        call SetUnitPathing(.load, false) 
        call UnitAddAbility(.load, 'Avul') 
        call UnitAddAbility(.load, 'Aloc') 
        call DestroyTimer(GetExpiredTimer()) 
    endmethod 
    static method target takes string ordername, unit u, integer level, integer spell_id returns nothing 
        call SetUnitX(.load, GetUnitX(u)) 
        call SetUnitY(.load, GetUnitY(u)) 
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
    private static method OnInit takes nothing returns nothing 
        call TimerStart(CreateTimer(), 0.01, false, function thistype.new) 
    endmethod 
endstruct 