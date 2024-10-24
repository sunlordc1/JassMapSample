struct Dialog 
    dialog d = DialogCreate() 
    button array btn[MAX_SIZE_DIALOG_BUTTON] 
    integer i = -1 
    trigger t = null 
    method displayx takes boolean flag, player p returns nothing 
        call DialogDisplay(p,.d, flag) 
    endmethod 
    method title takes string str returns nothing 
        call DialogSetMessage(.d, str) 
    endmethod 
    method event takes code func returns nothing 
        set.t = CreateTrigger() 
        call TriggerRegisterDialogEventBJ(.t,.d) 
        call TriggerAddAction(.t, func) 
    endmethod 
    //hotkey default 0    
    method addbtn takes string btn_text, integer hotkey returns button 
        set.i =.i + 1 
        set.btn[.i] = DialogAddButton(.d, btn_text, hotkey) 
        return.btn[i] 
    endmethod 
    method find takes button btn returns integer 
        local integer res = -1 
        set bj_int = 0 
        loop 
            exitwhen bj_int >.i 
            if.btn[bj_int] == btn then 
                set res = bj_int 
                exitwhen true 
            endif 
            set bj_int = bj_int + 1 
        endloop 
        return res 
    endmethod 
    //When button click u end the game, careful to use :))   
    method addbtnquit takes string btn_text, boolean endgame, integer hotkey returns nothing 
        set.i =.i + 1 
        set.btn[.i] = DialogAddQuitButton(.d, endgame, btn_text, hotkey) 
    endmethod 
    method destroyd takes nothing returns nothing 
        call DialogClear(.d) 
        call DialogDestroy(.d) 
        call DestroyTrigger(.t) 
        call.destroy() 
    endmethod 
endstruct