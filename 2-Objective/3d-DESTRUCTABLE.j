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
