  
//Uses : see code in file EXAMPLE.j
struct CountdownTimer 
    timer t = null 
    timerdialog td = null 
    method newdialog takes string title, real timeout, boolean periodic, code func returns nothing 
        set.t = CreateTimer() 
        call TimerStart(.t, timeout, periodic, func) 
        set.td = CreateTimerDialog(.t) 
        call TimerDialogSetTitle(.td, title) 
        call TimerDialogDisplay(.td, true) 
    endmethod 
    method pause takes boolean status returns nothing 
        if status then 
            call PauseTimer(.t) 
        else 
            call ResumeTimer(.t) 
        endif 
    endmethod 
    method title takes string title returns nothing 
        call TimerDialogSetTitle(.td, title) 
    endmethod 
    method titlecolor takes integer red, integer green, integer blue, integer transparency returns nothing 
        call TimerDialogSetTitleColor(.td, red, green, blue, transparency) 
    endmethod 
    method timercolor takes integer red, integer green, integer blue, integer transparency returns nothing 
        call TimerDialogSetTimeColor(.td, red, green, blue, transparency) 
    endmethod 
    method display takes boolean status returns nothing 
        call TimerDialogDisplay(.td, status) 
    endmethod 
    method displayx takes boolean status, player p returns nothing 
        if(GetLocalPlayer() == p) then 
            // Use only local code (no net traffic) within this block to avoid desyncs.       
            call TimerDialogDisplay(.td, status) 
        endif 
    endmethod 
    method destroytd takes nothing returns nothing 
        call DestroyTimerDialog(.td) 
        call DestroyTimer(.t) 
    endmethod 
endstruct