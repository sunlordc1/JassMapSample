struct Num 
    // Percent to real :                   
    // Use: Math.p2r(100,60) = 60% of 100 = 60                   
    static method p2r takes real CurrentNumber, real Percent returns real 
        return CurrentNumber * (Percent / 100) 
    endmethod 
    static method r2i takes real r returns integer 
        return R2I(r) 
    endmethod 
    static method i2r takes integer i returns real 
        return I2R(i) 
    endmethod 
    static method ri2s takes real r returns string 
        return I2S(R2I(r)) 
    endmethod 
    //====================================================================================  
    ///======Player   
    static method pid takes player whichPlayer returns integer 
        return GetPlayerId(whichPlayer) 
    endmethod 
   
    static method uid takes unit u returns integer 
        return GetPlayerId(GetOwningPlayer(u)) 
    endmethod 
endstruct