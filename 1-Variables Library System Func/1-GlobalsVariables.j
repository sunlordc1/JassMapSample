globals 
    //Number 
    integer bj_int = 0 
    real bj_real = 0.00 
    //Objective 
    item bj_item = null // instead of bj_lastCreatedItem  
    unit bj_unit = null // instead of bj_lastCreatedUnit  
    effect bj_effect = null // instead of bj_lastCreatedEffect  
    //Storage 
    hashtable ht = InitHashtable() // This is the hashtable you will use in most situations of the game.    
    //Timer 
    constant real TIME_SETUP_EVENT = 0.2 // The time to start setting up events for the game.  
    //Utils 
    constant string SYSTEM_CHAT = "[SYSTEM]: |cffffcc00" 
endglobals 

