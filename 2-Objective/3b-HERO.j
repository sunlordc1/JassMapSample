
struct Hero extends Unit 
    static method str takes unit u returns integer 
        return GetHeroStr(u, true) 
    endmethod 
    static method setstr takes unit u, integer value, boolean flag returns nothing 
        call SetHeroStr(u, value, flag) 
    endmethod 
    static method int takes unit u returns integer 
        return GetHeroInt(u, true) 
    endmethod 
    static method setint takes unit u, integer value, boolean flag returns nothing 
        call SetHeroInt(u, value, flag) 
    endmethod 
    static method agi takes unit u returns integer 
        return GetHeroAgi(u, true) 
    endmethod 
    static method setagi takes unit u, integer value, boolean flag returns nothing 
        call SetHeroAgi(u, value, flag) 
    endmethod 
    static method all takes unit u returns integer 
        return GetHeroAgi(u, true) + GetHeroInt(u, true) + GetHeroStr(u, true) 
    endmethod 
    static method revive takes unit u, real x, real y, boolean flag returns nothing 
        call ReviveHero(u, x, y, flag) 
    endmethod 
    static method addexp takes unit u, integer value, boolean flag returns nothing 
        call AddHeroXP(u, value, flag) 
    endmethod 
    static method setlv takes unit u, integer level, boolean flag returns nothing 
        call SetHeroLevel(u, level, flag) 
    endmethod 
    static method propername takes unit u, integer level, boolean flag returns nothing 
        call GetHeroProperName(u) 
    endmethod 
endstruct