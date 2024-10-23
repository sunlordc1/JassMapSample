struct Item 
    // Charge Item     
    static method removecharge takes item i, integer req returns nothing 
        call SetItemCharges(i, GetItemCharges(i) -req) 
        if GetItemCharges(i) <= 0 then 
            call RemoveItem(i) 
        endif 
    endmethod 
endstruct 
