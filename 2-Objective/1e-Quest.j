struct Questmsg 
    static integer DISCOVERED = 0 
    static integer UPDATED = 1 
    static integer COMPLETED = 2 
    static integer FAILED = 3 
    static integer REQUIREMENT = 4 
    static integer MISSIONFAILED = 5 
    static integer ALWAYSHINT = 6 
    static integer HINT = 7 
    static integer SECRET = 8 
    static integer UNITACQUIRED = 9 
    static integer UNITAVAILABLE = 10 
    static integer ITEMACQUIRED = 11 
    static integer WARNING = 12 
endstruct 
struct Questtype 
    static integer REQ_DISCOVERED = 0 
    static integer OPT_DISCOVERED = 2 
    static integer REQ_UNDISCOVERED = 1 
    static integer OPT_UNDISCOVERED = 3 
endstruct 
//Make only one time with .new () deafeat condition in quest tab , change it with .desc if you change condition to defeat                
struct DeafeatQuest 
    static method new takes string desc returns nothing 
        set bj_lastCreatedDefeatCondition = CreateDefeatCondition() 
        call DefeatConditionSetDescription(bj_lastCreatedDefeatCondition, desc) 
        call FlashQuestDialogButton() 
    endmethod 
    static method desc takes string str returns nothing 
        call DefeatConditionSetDescription(bj_lastCreatedDefeatCondition, str) 
        call FlashQuestDialogButton() 
    endmethod 
    static method destroydq takes string desc returns nothing 
        call DestroyDefeatCondition(bj_lastCreatedDefeatCondition) 
    endmethod 
endstruct 

struct Quest 
    quest q = null 
    //new ( questType,  title,  description,  iconPath)   
    method new takes integer questType, string title, string description, string iconPath returns nothing 
        local boolean required = (questType == 0) or(questType == 1) 
        local boolean discovered = (questType == 0) or(questType == 2) 
        set.q = CreateQuest() 
        call QuestSetTitle(.q, title) 
        call QuestSetDescription(.q, description) 
        call QuestSetIconPath(.q, iconPath) 
        call QuestSetRequired(.q, required) 
        call QuestSetDiscovered(.q, discovered) 
        call QuestSetCompleted(.q, false) 
    endmethod 
 
  
    //GET       
    //======Status    
    method enabled takes nothing returns boolean 
        return IsQuestEnabled(.q) 
    endmethod 
    method completed takes nothing returns boolean 
        return IsQuestCompleted(.q) 
    endmethod 
    method failed takes nothing returns boolean 
        return IsQuestFailed(.q) 
    endmethod 
    method discovered takes nothing returns boolean 
        return IsQuestDiscovered(.q) 
    endmethod 
    method required takes nothing returns boolean 
        return IsQuestRequired(.q) 
    endmethod 
    //SET       
    //=====Status    
    method setenabled takes boolean status returns nothing 
        call QuestSetEnabled(.q, status) 
    endmethod 
    method setcompleted takes boolean status returns nothing 
        call QuestSetCompleted(.q, status) 
    endmethod 
    method setfailed takes boolean status returns nothing 
        call QuestSetFailed(.q, status) 
    endmethod 
    method setdiscovered takes boolean status returns nothing 
        call QuestSetDiscovered(.q, status) 
    endmethod 
    method setrequired takes boolean status returns nothing 
        call QuestSetRequired(.q, status) 
    endmethod 
    //=====Content    
    method title takes string str returns nothing 
        call QuestSetTitle(.q, str) 
    endmethod 
    method desc takes string str returns nothing 
        call QuestSetDescription(.q, str) 
    endmethod 

    /////////////       
    method flash takes nothing returns nothing 
        call FlashQuestDialogButton() 
    endmethod 
    method destroyq takes nothing returns nothing 
        call DestroyQuest(.q) 
    endmethod 
   
endstruct 

struct Questitem 
    questitem qi = null 
    method new takes quest q, string description returns nothing 
        set.qi = QuestCreateItem(q) 
        call QuestItemSetDescription(.qi, description) 
        call QuestItemSetCompleted(.qi, false) 
    endmethod 
    method desc takes string str returns nothing 
        call QuestItemSetDescription(.qi, str) 
    endmethod 
    method completed takes nothing returns boolean 
        return IsQuestItemCompleted(.qi) 
    endmethod 
    method setcompleted takes boolean status returns nothing 
        call QuestItemSetCompleted(.qi, status) 
    endmethod 
endstruct