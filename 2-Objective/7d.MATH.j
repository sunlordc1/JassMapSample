struct Math 
    static method rate takes real r returns boolean
        local real rand = 0 
        set rand = GetRandomReal(0,100) 
        if rand != 0 and rand <= r then 
            return true 
        endif  
        return false 
    endmethod
    //Calculates the terrain height (Z-coordinate) at a specified (x, y) location in the game               
    //Use: Math.pz(x,y)              
    static method pz takes real x, real y returns real 
        call MoveLocation(bj_loc, x, y) 
        return GetLocationZ(bj_loc) 
    endmethod 

    //Calculate the angle between two points. Facing (x1,y1) to (x2,y2)               
    //Use: Math.ab(x1,y1,x2,y2)              
    static method ab takes real x1, real y1, real x2, real y2 returns real 
        return bj_RADTODEG * Atan2(y2 - y1, x2 - x1) 
    endmethod 

    //Calculate the angle between two units. Facing u to u2               
    //Use: Math.abu(u,u2)              
    static method abu takes unit u, unit u2 returns real 
        local real x1 = GetUnitX(u) 
        local real y1 = GetUnitY(u) 
        local real x2 = GetUnitX(u2) 
        local real y2 = GetUnitY(u2) 
        return bj_RADTODEG * Atan2(y2 - y1, x2 - x1) 
    endmethod 

    //Calculate the distance between two points         
    //Use: Math.db(x1,y1,x2,y2)            
    static method db takes real x1, real y1, real x2, real y2 returns real 
        local real dx = x2 - x1 
        local real dy = y2 - y1 
        return SquareRoot(dx * dx + dy * dy) 
    endmethod 
    
    //Calculate the distance between two units         
    //Use: Math.dbu(u,u2)         
    static method dbu takes unit u, unit u2 returns real 
        local real dx = GetUnitX(u2) -GetUnitX(u) 
        local real dy = GetUnitY(u2) -GetUnitY(u) 
        return SquareRoot(dx * dx + dy * dy) 
    endmethod 
    
    //calculates the new X-coordinate when moving a certain distance in a specified direction (angle) from a starting point    
    //Use: Math.ppx(currentX,distance,angle)       
    static method ppx takes real x, real dist, real angle returns real 
        return x + dist * Cos(angle * bj_DEGTORAD) 
    endmethod 

    //calculates the new Y-coordinate when moving a certain distance in a specified direction (angle) from a starting point       
    //Use: Math.ppy(currentY,distance,angle)       
    static method ppy takes real y, real dist, real angle returns real 
        return y + dist * Sin(angle * bj_DEGTORAD) 
    endmethod 

    //calculates the combined height of a unit in the game, which consists of the terrain height at the unit's location and the unit's flying height above the ground.     
    //Use: Math.uz(u)       
    static method uz takes unit u returns real 
        call MoveLocation(bj_loc, GetUnitX(u), GetUnitY(u)) 
        return GetLocationZ(bj_loc) + GetUnitFlyHeight(u) 
    endmethod 

  
endstruct