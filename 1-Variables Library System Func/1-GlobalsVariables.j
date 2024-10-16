globals 
    //Number
    integer INT = 0 
    real REAL = 0.00 
    //Objective
    item ITEM = null // instead of bj_lastCreatedItem 
    unit UNIT = null // instead of bj_lastCreatedUnit 
    effect EFFECT = null // instead of bj_lastCreatedEffect 
    //Timer
    constant real TIME_SETUP_EVENT = 0.2 // The time to start setting up events for the game.   
    //Storage
    hashtable ht = InitHashtable() // This is the hashtable you will use in most situations of the game.   
endglobals 

