
///======= Preload Function   
// === When creating a new ability or unit that hasn't been used in the map,he game may experience a slight lag.   
// === Therefore, you should initialize them at the start of the game to ensure a smooth gameplay experience.  

function Preload_Unit takes integer id returns nothing 
    call RemoveUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), id, 0, 0, 270)) 
endfunction 
   
function Preload_Item takes integer id returns nothing 
    call RemoveItem(CreateItem(id, 0, 0)) 
endfunction 
   
function Preload_Ability takes integer id returns nothing 
    local unit u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nzin', 0, 0, 270) 
    call UnitAddAbility(u, id) 
    call UnitRemoveAbility(u, id) 
    call RemoveUnit(u) 
    set u = null 
endfunction 
   
function Preload_Sound takes unit u, string path returns nothing 
    local sound s = CreateSound(path, false, true, true, 12700, 12700, "") 
    call SetSoundVolume(s, 100) 
    call AttachSoundToUnit(s, u) 
    call StartSound(s) 
    call KillSoundWhenDone(s) 
endfunction 

//====================================================================================  
///======= Ultils   




