struct Str
    //Use:  Str.repeated(1234567,",",3,0) -> 123,456,7 
    static method repeated takes string s, string str, integer spacing, integer start returns string 
        local integer i = StringLength(s) 
        local integer p = 1 
        loop 
            exitwhen p * spacing + start >= i 
            set s = SubString(s, 0, p * spacing + p + start - 1) + str + SubString(s, p * spacing + p + start - 1, StringLength(s)) 
            set p = p + 1 
        endloop 
        return s 
    endmethod 
    //Use: Str.reverse("1234") -> 4321
    static method reverse takes string s returns string
        local integer i = StringLength(s)
        local string rs = ""
        loop
            set i = i - 1
            set rs = rs + SubString(s, i, i + 1)
            exitwhen i == 0
        endloop
        return rs
    endmethod
endstruct 