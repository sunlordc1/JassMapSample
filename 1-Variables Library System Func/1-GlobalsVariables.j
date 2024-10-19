
//Constant : A constant value does not change, and you use it to set fixed parameters in the game. 
globals 
    //We will define bj_ as a type of variable that is used and processed at a specific moment, 
    // is always redefined when it starts being used, and is assigned a null value when finished. 
    //Number  
    integer bj_int = 0 // Typically used for a single loop or assigning a random value. 
    real bj_real = 0.00 //Typically used for a single loop or assigning a random value. 
    //Objective  
    item bj_item = null // instead of bj_lastCreatedItem   
    unit bj_unit = null // instead of bj_lastCreatedUnit   
    effect bj_eff = null // instead of bj_lastCreatedEffect   
    //Storage  
    hashtable ht = InitHashtable() // This is the hashtable you will use in most situations of the game.    
    //Timer  
    constant real TIME_SETUP_EVENT = 0.2 // The time to start setting up events for the game.   
    constant real P32 = 0.03125 // Explore this number; it truly has significance. 
    constant real P64 = 0.03125*2 // Explore this number; it truly has significance. 
    //Utils  
    constant string SYSTEM_CHAT = "[SYSTEM]: |cffffcc00" 
    constant boolean ENV_DEV = true // Are u on a testing mode ?

    //Setting Game 
    constant boolean CREEP_SLEEP = false
    constant boolean LOCK_RESOURCE_TRADING = true
    constant boolean SHARED_ADVANCED_CONTROL = false
    constant real GAME_PRELOAD_TIME = 0.01
    constant real GAME_STATUS_TIME = 1.00
    constant real GAME_SETTING_TIME = 3.00
    constant real GAME_START_TIME = 5.00

    
endglobals 

