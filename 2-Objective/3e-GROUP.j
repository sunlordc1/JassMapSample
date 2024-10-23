struct Group 
    static method pick takes group g returns unit 
        return FirstOfGroup(g) 
    endmethod 
    static method get takes group whichGroup, integer index returns unit 
        return BlzGroupUnitAt(whichGroup, index) 
    endmethod 
    static method size takes group whichGroup returns integer 
        return BlzGroupGetSize(whichGroup) 
    endmethod 
    static method add takes unit whichUnit, group whichGroup returns boolean 
        return GroupAddUnit(whichGroup, whichUnit) 
    endmethod 
    static method remove takes unit whichUnit, group whichGroup returns boolean 
        return GroupRemoveUnit(whichGroup, whichUnit) 
    endmethod 
    static method have takes unit whichUnit, group whichGroup returns boolean 
        return IsUnitInGroup(whichUnit, whichGroup) 
    endmethod 
    static method release takes group whichGroup returns nothing 
        call GroupClear(whichGroup) 
        call DestroyGroup(whichGroup) 
    endmethod 
    static method enum takes group whichGroup, real x, real y, real radius returns nothing 
        call GroupEnumUnitsInRange(whichGroup, x, y, radius, null) 
    endmethod 
    static method enump takes group whichGroup, player p returns nothing 
        call GroupEnumUnitsOfPlayer(whichGroup, p, null) 
    endmethod 
    static method new takes nothing returns group 
        return CreateGroup() 
    endmethod 
endstruct 