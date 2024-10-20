//Call struct then Unit instead UNIT   
struct Unit 
    //=================Position================================      
    method x takes unit u returns real 
        return GetUnitX(u) 
    endmethod 
    method y takes unit u returns real 
        return GetUnitY(u) 
    endmethod 
    method z takes unit u returns real 
        return GetUnitFlyHeight(u) 
    endmethod 
    method setx takes unit u, real x returns nothing 
        call SetUnitX(u, x) 
    endmethod 
    method sety takes unit u, real y returns nothing 
        call SetUnitY(u, y) 
    endmethod 
    // Set Flying Height (Required unit have crow form or fly)         
    // Use: Unit.setz(u,height)         
    method setz takes unit u, real height returns nothing 
        call SetUnitFlyHeight(u, height, 0.) 
    endmethod 

    
    //==================Movespeed=========================      
    // Reset MoveSpeed of unit to default      
    method resetms takes unit whichUnit returns nothing 
        call SetUnitMoveSpeed(whichUnit, GetUnitDefaultMoveSpeed(whichUnit)) 
    endmethod 
    // Get MoveSpeed of unit      
    // Use: Unit.ms(u)        
    method ms takes unit whichUnit returns real 
        return GetUnitMoveSpeed(whichUnit) 
    endmethod 

    //==================Vertex Color=========================      
    //Reset Vertex Color [Change Color and Alpha of Unit]      
    //Use:  Unit.resetvertexcolor(u)       
    method resetvertexcolor takes unit u returns nothing 
        call SetUnitVertexColor(u, 255, 255, 255, 255) 
    endmethod 

    //Set Vertex Color [Change Color and Alpha of Unit]      
    //Use:  Unit.vertexcolor(u)       
    method vertexcolor takes unit u, integer red, integer green, integer blue, integer alpha returns nothing 
        call SetUnitVertexColor(u, red, green, blue, alpha) 
    endmethod 

    //==================Misc=========================      
    // Get Collision of unit u         
    // Use: Unit.collision(u)         
    method collision takes unit u returns real 
        local real l = 0 
        local real h = 300 
        local real m = 150 
        local real nm = 0 
        local real x = GetUnitX(u) 
        local real y = GetUnitY(u) 
        loop 
            if(IsUnitInRangeXY(u, x + m, y, 0)) then 
                set l = m 
            else 
                set h = m 
            endif 
            set nm = (l + h) / 2 
            exitwhen nm + .001 > m and nm - .001 < m 
            set m = nm 
        endloop 
        return R2I(m * 10) / 10. 
    endmethod 
    //==================== Ability =======================  
    static method abilv takes unit u, integer a returns integer 
        local integer i = 0 
        set i = GetUnitAbilityLevel(u, a) 
        return i 
    endmethod 
    static method setabilv takes unit u, integer a, integer lv returns nothing 
        call SetUnitAbilityLevel(u, a, lv) 
    endmethod 
    static method removeabi takes unit u, integer a returns nothing 
        call UnitRemoveAbility(u, a) 
    endmethod 
    static method haveabi takes unit u, integer a returns boolean 
        return GetUnitAbilityLevel(u, i) > 0 
    endmethod 
    static method addabi takes unit u, integer a returns nothing 
        call UnitAddAbility(u, a) 
        call UnitMakeAbilityPermanent(u, true, a) 
    endmethod 
    static method hideabi takes unit u, integer a returns nothing 
        call BlzUnitHideAbility(u, a, true) 
    endmethod 
    static method showabi takes unit u, integer a returns nothing 
        call BlzUnitDisableAbility(u, a, false, false) 
    endmethod 
    static method disabledabi takes unit u, integer a returns nothing 
        call BlzUnitDisableAbility(u, a, true, false) 
    endmethod 




    private static method onInit takes nothing returns nothing 
        local thistype this = thistype.create() 
    endmethod 
endstruct