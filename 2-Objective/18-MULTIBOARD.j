// call CreateMultiboardBJ(1, 1, "TRIGSTR_035")             
// call DestroyMultiboardBJ(GetLastCreatedMultiboard()) 
// call MultiboardDisplayBJ(false, GetLastCreatedMultiboard())           
// call MultiboardAllowDisplayBJ(false) 
// call MultiboardMinimizeBJ(true, GetLastCreatedMultiboard())           
// call MultiboardClear(GetLastCreatedMultiboard())           
// call MultiboardSetTitleText(GetLastCreatedMultiboard(), "TRIGSTR_034")          
// call MultiboardSetTitleTextColorBJ(GetLastCreatedMultiboard(), 100, 80, 20, 0)         
// call MultiboardSetRowCount(GetLastCreatedMultiboard(), 1)         
// call MultiboardSetColumnCount(GetLastCreatedMultiboard(), 1)         
// call MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 1, 1, true, true)        
// call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 1, "TRIGSTR_037")       
// call MultiboardSetItemColorBJ(GetLastCreatedMultiboard(), 1, 1, 100, 80, 20, 0)   
// call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, 3)  
// call MultiboardSetItemIconBJ(GetLastCreatedMultiboard(), 1, 1, "UI\\Feedback\\Resources\\ResourceGold.blp") 
struct Multiboard 
    multiboard mb 
    multiboarditem mbitem = null 

    method new takes integer rows, integer cols, string title returns nothing 
        set.mb = CreateMultiboard() 
        call MultiboardSetRowCount(.mb, rows) 
        call MultiboardSetColumnCount(.mb, cols) 
        call MultiboardSetTitleText(.mb, title) 
        call MultiboardDisplay(.mb, true) 
    endmethod 
    method display takes boolean status returns nothing 
        call MultiboardDisplay(.mb, status) 
    endmethod 
    method displayx takes boolean status, player p returns nothing 
        if(GetLocalPlayer() == p) then 
            // Use only local code (no net traffic) within this block to avoid desyncs.                  
            call MultiboardDisplay(.mb, status) 
        endif 
    endmethod 
    method minimize takes boolean minimize returns nothing 
        call MultiboardMinimize(.mb, minimize) 
    endmethod 
    method clear takes nothing returns nothing 
        call MultiboardClear(.mb) 
    endmethod 
    method title takes string title returns nothing 
        call MultiboardSetTitleText(.mb, title) 
    endmethod 
    method colortitle takes integer red, integer green, integer blue, integer transparency returns nothing 
        call MultiboardSetTitleTextColor(.mb, red, green, blue, transparency) 
    endmethod 
    method rowcount takes integer row returns nothing 
        call MultiboardSetRowCount(.mb, row) 
    endmethod 
    method colcount takes integer col returns nothing 
        call MultiboardSetColumnCount(.mb, col) 
    endmethod 
    //Dont use it.    
    method finditem takes integer col, integer row returns nothing 
        local integer curRow = 0 
        local integer curCol = 0 
        local integer numRows = MultiboardGetRowCount(.mb) 
        local integer numCols = MultiboardGetColumnCount(.mb) 
        loop 
            set curRow = curRow + 1 
            exitwhen curRow > numRows 
            if(row == 0 or row == curRow) then 
                set curCol = 0 
                loop 
                    set curCol = curCol + 1 
                    exitwhen curCol > numCols 
                    if(col == 0 or col == curCol) then 
                        set.mbitem = MultiboardGetItem(.mb, curRow - 1, curCol - 1) 
                    endif 
                endloop 
            endif 
        endloop 
    endmethod 
    //Show value and icon in col of row     
    method setstyle takes integer col, integer row, boolean showValue, boolean showIcon returns nothing 
        call.finditem(col, row) 
        call MultiboardSetItemStyle(.mbitem, showValue, showIcon) 
        call MultiboardReleaseItem(.mbitem) 
    endmethod 
    method setvalue takes integer col, integer row, string val returns nothing 
        call.finditem(col, row) 
        call MultiboardSetItemValue(.mbitem, val) 
        call MultiboardReleaseItem(.mbitem) 
    endmethod 
    method setcolor takes integer col, integer row, integer red, integer green, integer blue, integer transparency returns nothing 
        call.finditem(col, row) 
        call MultiboardSetItemValueColor(.mbitem, red, green, blue, transparency) 
        call MultiboardReleaseItem(.mbitem) 
    endmethod 
    method setwidth takes integer col, integer row, real width returns nothing 
        call.finditem(col, row) 
        call MultiboardSetItemWidth(.mbitem, width / 100.0) 
        call MultiboardReleaseItem(.mbitem) 
    endmethod 
    method seticon takes integer col, integer row, string path returns nothing 
        call.finditem(col, row) 
        call MultiboardSetItemIcon(.mbitem, path) 
        call MultiboardReleaseItem(.mbitem) 
    endmethod 
endstruct