
struct Hero extends Unit
    static method str takes unit u returns integer 
        return GetHeroStr(u, true) 
    endmethod 
    static method int takes unit u returns integer 
        return GetHeroInt(u, true) 
    endmethod 
    static method agi takes unit u returns integer 
        return GetHeroAgi(u, true) 
    endmethod 
    static method all takes unit u returns integer 
        return GetHeroAgi(u, true) + GetHeroInt(u, true) + GetHeroStr(u, true) 
    endmethod 
endstruct