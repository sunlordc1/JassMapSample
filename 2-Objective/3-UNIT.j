struct Unit 
    //=================Position================================  
    static method x takes unit u returns real 
        return GetUnitX(u) 
    endmethod 
    static method y takes unit u returns real 
        return GetUnitY(u) 
    endmethod 
    static method z takes unit u returns real 
        return GetUnitFlyHeight(u) 
    endmethod 
    static method setx takes unit u, real x returns nothing 
        call SetUnitX(u, x) 
    endmethod 
    static method sety takes unit u, real y returns nothing 
        call SetUnitY(u, y) 
    endmethod 
    // Set Flying Height (Required unit have crow form or fly)     
    // Use: Unit.setz(u,height)     
    static method setz takes unit u, real height returns nothing 
        call SetUnitFlyHeight(u, height, 0.) 
    endmethod 

    
    //==================Movespeed=========================  
    // Reset MoveSpeed of unit to default  
    static method resetms takes unit whichUnit returns nothing 
        call SetUnitMoveSpeed(whichUnit, GetUnitDefaultMoveSpeed(whichUnit)) 
    endmethod 
    // Get MoveSpeed of unit  
    // Use: Unit.ms(u)    
    static method ms takes unit whichUnit returns real 
        return GetUnitMoveSpeed(whichUnit) 
    endmethod 

    //==================Vertex Color=========================  
    //Reset Vertex Color [Change Color and Alpha of Unit]  
    //Use:  Unit.resetvertexcolor(u)   
    static method resetvertexcolor takes unit u returns nothing 
        call SetUnitVertexColor(u, 255, 255, 255, 255) 
    endmethod 

    //Set Vertex Color [Change Color and Alpha of Unit]  
    //Use:  Unit.vertexcolor(u)   
    static method vertexcolor takes unit u, integer red, integer green, integer blue, integer alpha returns nothing 
        call SetUnitVertexColor(u, red, green, blue, alpha) 
    endmethod 

    //==================Misc=========================  
    // Get Collision of unit u     
    // Use: Unit.collision(u)     
    static method collision takes unit u returns real 
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

endstruct