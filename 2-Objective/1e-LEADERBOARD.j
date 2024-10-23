//I don't use leaderboard and not have experience for do it...

// call CreateLeaderboardBJ( GetPlayersAll(), "TRIGSTR_040" )    
// call DestroyLeaderboardBJ( GetLastCreatedLeaderboard() )    
// call LeaderboardSortItemsBJ( GetLastCreatedLeaderboard(), bj_SORTTYPE_SORTBYVALUE, false )    
// call LeaderboardDisplayBJ( false, GetLastCreatedLeaderboard() )    
// call LeaderboardSetLabelBJ( GetLastCreatedLeaderboard(), "TRIGSTR_042" )    
// call LeaderboardSetLabelColorBJ( GetLastCreatedLeaderboard(), 100, 80, 20, 0 )    
// call LeaderboardSetValueColorBJ( GetLastCreatedLeaderboard(), 100, 80, 20, 0 )    
// call LeaderboardSetStyleBJ( GetLastCreatedLeaderboard(), true, true, true, true )    
// call LeaderboardAddItemBJ( Player(0), GetLastCreatedLeaderboard(), "TRIGSTR_044", 0 )    
// call LeaderboardRemovePlayerItemBJ( Player(0), GetLastCreatedLeaderboard() )    
// call LeaderboardSetPlayerItemLabelBJ( Player(0), GetLastCreatedLeaderboard(), "TRIGSTR_046" )    
// call LeaderboardSetPlayerItemLabelColorBJ( Player(0), GetLastCreatedLeaderboard(), 100, 80, 20, 0 )    
// call LeaderboardSetPlayerItemValueBJ( Player(0), GetLastCreatedLeaderboard(), 0 )    
// call LeaderboardSetPlayerItemValueColorBJ( Player(0), GetLastCreatedLeaderboard(), 100, 80, 20, 0 )    
// call LeaderboardSetPlayerItemStyleBJ( Player(0), GetLastCreatedLeaderboard(), true, true, true )  

//Uses : see code in file EXAMPLE.j
// struct Leaderboard 
//     leaderboard lb 
//     method new takes string title returns nothing 
//         set.lb = CreateLeaderboard() 
//         call LeaderboardSetLabel(.lb, title) 
//     endmethod 
//     method setforce takes force f, boolean display returns nothing 
//         call ForceSetLeaderboardBJ(.lb, f) 
//         call LeaderboardDisplay(.lb, display) 
//     endif 
//     method display takes boolean status returns nothing 
//         call LeaderboardDisplay(.lb, status) 
//     endmethod 
//     method displayx takes boolean status, player p returns nothing 
//         if(GetLocalPlayer() == p) then 
//             // Use only local code (no net traffic) within this block to avoid desyncs.                     
//             call LeaderboardDisplay(.lb, status) 
//         endif 
//     endmethod 
//     method setlabel takes string label returns nothing 
//         local integer size = LeaderboardGetItemCount(lb) 
//         call LeaderboardSetLabel(.lb, label) 
//         if(LeaderboardGetLabelText(.lb) == "") then 
//             set size = size - 1 
//         endif 
//         call LeaderboardSetSizeByItemCount(lb, size) 
//     endmethod 

//     method destroylb takes boolean status returns nothing 
//         call DestroyLeaderboard(.lb) 
//     endmethod 
// endstruct