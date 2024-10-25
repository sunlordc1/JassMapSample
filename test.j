struct RegionMap 
    integer x 
    integer y 
    region rg = CreateRegion() 
    trigger t = CreateTrigger() 
    integer map_id 
    method onSetup takes integer x, integer y, integer map_id returns nothing 
        set this.x = x 
        set this.y = y 
        set this.rg = rg 
        set this.map_id = map_id 
    endmethod 
endstruct 

struct RandomMap 
    static integer array grid512[120] [120] 
    static integer array grid1024[60] [60] 
    static integer array grid1536[40] [40] 
    static integer array grid2048[30] [30] 
    static integer size = 0 
    static RegionMap array region_map 
    static rect x1536 = Rect(-768, -768, 768, 768) 
    static method InitGridx2048 takes nothing returns nothing 

        local integer x = -15 
        local integer y = -15 
        local integer count = 0 
        // Khởi tạo ma trận với giá trị mặc định là 1                                                                                                              
        loop 
            exitwhen x > 15 // Kiểm tra điều kiện thoát vòng lặp                                                                                                              
            set y = -15 // Đặt lại y về giá trị bắt đầu                                                                                                              
    
            loop 
                exitwhen y > 15 // Kiểm tra điều kiện thoát vòng lặp                                                                                           
                set.grid2048[x + 15] [y + 15] = -1 //Khong co data                                                            
                if x != 15 and y != 15 and x != -15 and y != -15 then 
                    set.grid2048[x + 15] [y + 15] = GetRandomInt(1, 60) // Random id map                                                             
                    if(ModuloInteger(x + y, 2) == 0) then 
                        call SetTerrainType(x * 2048, y * 2048, 'Ldrt', GetRandomInt(0, 7), 9, 1) 
                        call.AddRandomDestructables(x * 2048, y * 2048) 
                    else 
                        call SetTerrainType(x * 2048, y * 2048, 'Lgrs', GetRandomInt(0, 7), 9, 1) 
                        call.AddRandomDestructables(x * 2048, y * 2048) 
                    endif 
                endif 
                set count = count + 1 //961 = 31x31                                                                
                set y = y + 1 // Tăng y                                                                                                              
            endloop 
    
            set x = x + 1 // Tăng x                                                                                                              
        endloop 
        call BJDebugMsg("Count: " + I2S(count)) 
    endmethod 
    static method onEnter takes nothing returns nothing 
        local region rg = GetTriggeringRegion() 
        local integer id = 0 
        set id =.find_map_id(rg) 
        call BJDebugMsg("hello") 
        if id != -1 then 
            call BJDebugMsg("X: " + I2S(.region_map[id].x) + " []Y:" + I2S(.region_map[id].y) + " []Map_id: " + I2S(.region_map[id].map_id) + " []ID: " + I2S(id)) 
        endif 

    endmethod 
    static method find_map_id takes region rg returns integer 
        local integer n = 0 
        local integer res = -1 
        loop 
            exitwhen n >.size 
            if rg ==.region_map[n].rg then 
                set res = n 
                exitwhen true 
            endif 
            set n = n + 1 
        endloop 
        return res 
    endmethod 
    static method RandomMapx1536 takes nothing returns nothing 
        local integer x = -10 
        local integer y = -10 
        local integer rx = 0 
        local integer ry = 0 
        local RegionMap regm 
        local rect r 
        set rx = GetRandomInt(-9, 9) 
        set ry = GetRandomInt(-9, 9) 
        // Khởi tạo ma trận với giá trị mặc định là 1                     

        set.size = -1 
        set x = rx - 10 
        set y = ry - 10 
        loop 
            exitwhen x > rx + 10 // Kiểm tra điều kiện thoát vòng lặp                                                                                                              
            set y = ry - 10 // Đặt lại y về giá trị bắt đầu                                                                                                              
    
            loop 
                exitwhen y > ry + 10 // Kiểm tra điều kiện thoát vòng lặp                                 
                set.size =.size + 1 //961 = 41x41                                   
  
                call BJDebugMsg(I2S(.size)) 
                set.region_map[.size] = regm.create() 
                set r = Rect((x * 1536) -768, (y * 1536) -768, (x * 1536) + 768, (y * 1536) + 768) 
                // call MoveRectTo(.x1536, x * 1536, y * 1536)              
                call RegionAddRect(.region_map[.size].rg, r) 
                call RemoveRect(r) 
                call.region_map[.size].onSetup(x, y, GetRandomInt(1, 60) ) 
                call TriggerRegisterEnterRegion(.region_map[.size].t,.region_map[.size].rg, null) 
                call TriggerAddAction(.region_map[.size].t, function thistype.onEnter) 

                set.grid1536[x + 10] [y + 10] = GetRandomInt(1, 60) // Gán 1 cho tất cả các vị trí                                                                                                 
                if(ModuloInteger(x + y, 2) == 0) then 
                    call SetTerrainType((x) * 1536, (y) * 1536, 'Ldrt', GetRandomInt(0, 7), 7, 1) 
                    call.AddRandomDestructables((x) * 1536, (y) * 1536) 
                else 
                    call SetTerrainType((x) * 1536, (y) * 1536, 'Lgrs', GetRandomInt(0, 7), 7, 1) 
                    call.AddRandomDestructables((x) * 1536, (y) * 1536) 
                endif 
                set y = y + 1 // Tăng y                                                                
                                                                            
            endloop 
    
            set x = x + 1 // Tăng x                                                                                                              
        endloop 
        call BJDebugMsg("X: " + I2S(rx) + " [] Y:" + I2S(ry) + "Count: " + I2S(.size + 1)) 

    endmethod 
    static method InitGridx1536 takes nothing returns nothing 
        local integer x = -20 
        local integer y = -20 
        local integer count = 0 
      
        // Khởi tạo ma trận với giá trị mặc định là 1                                                                                                              
        loop 
            exitwhen x > 20 // Kiểm tra điều kiện thoát vòng lặp                                                                                                              
            set y = -20 // Đặt lại y về giá trị bắt đầu                                                                                                              
    
            loop 
                exitwhen y > 20 // Kiểm tra điều kiện thoát vòng lặp                                                                  
                set.grid1536[x + 20] [y + 20] = -1 //Khong co data                                                            
                if x != 20 and y != 20 and x != -20 and y != -20 then 
                    set.grid1536[x + 20] [y + 20] = GetRandomInt(1, 60) // Gán 1 cho tất cả các vị trí                                                                                                 
                    if(ModuloInteger(x + y, 2) == 0) then 
                        call SetTerrainType(x * 1536, y * 1536, 'Ldrt', GetRandomInt(0, 7), 7, 1) 
                        call.AddRandomDestructables(x * 1536, y * 1536) 
                    else 
                        call SetTerrainType(x * 1536, y * 1536, 'Lgrs', GetRandomInt(0, 7), 7, 1) 
                        call.AddRandomDestructables(x * 1536, y * 1536) 
                    endif 
                endif 
                set y = y + 1 // Tăng y                                                                
                set count = count + 1 //961 = 41x41                                                                                                              
            endloop 
    
            set x = x + 1 // Tăng x                                                                                                              
        endloop 
        call BJDebugMsg("Count: " + I2S(count)) 

    endmethod 
    static method InitGridx1024 takes nothing returns nothing 
        local integer x = -30 
        local integer y = -30 
    
        // Khởi tạo ma trận với giá trị mặc định là 1                                                                                                              
        loop 
            exitwhen x > 30 // Kiểm tra điều kiện thoát vòng lặp                                                                                                              
            set y = -30 // Đặt lại y về giá trị bắt đầu                                                                                                              
    
            loop 
                exitwhen y > 30 // Kiểm tra điều kiện thoát vòng lặp                                                                                           
                set.grid1024[x + 30] [y + 30] = 1 // Gán 1 cho tất cả các vị trí                                                                                                 
                if(ModuloInteger(x + y, 2) == 0) then 
                    call SetTerrainType(x * 1024, y * 1024, 'Ldrt', GetRandomInt(0, 7), 5, 1) 
                    call.AddRandomDestructables(x * 1024, y * 1024) 
                else 
                    call SetTerrainType(x * 1024, y * 1024, 'Lgrs', GetRandomInt(0, 7), 5, 1) 
                endif 
                set y = y + 1 // Tăng y                                                                                                              
            endloop 
    
            set x = x + 1 // Tăng x                                                                                                              
        endloop 
    endmethod 
    static method InitGridx512 takes nothing returns nothing 
        local integer x = -60 
        local integer y = -60 
    
        // Khởi tạo ma trận với giá trị mặc định là 1                                                                                                              
        loop 
            exitwhen x > 60 // Kiểm tra điều kiện thoát vòng lặp                                                                                                              
            set y = -60 // Đặt lại y về giá trị bắt đầu                                                                                                              
    
            loop 
                exitwhen y > 60 // Kiểm tra điều kiện thoát vòng lặp                                                                                           
                set.grid512[x + 60] [y + 60] = 1 // Gán 1 cho tất cả các vị trí                                                                                                 
                if(ModuloInteger(x + y, 2) == 0) then 
                    call SetTerrainType(x * 512, y * 512, 'Ldrt', GetRandomInt(0, 7), 3, 1) 
                    call.AddRandomDestructables(x * 512, y * 512) 
                else 
                    call SetTerrainType(x * 512, y * 512, 'Lgrs', GetRandomInt(0, 7), 3, 1) 
                    call.AddRandomDestructables(x * 512, y * 512) 
                endif 
                set y = y + 1 // Tăng y                                                                                                              
            endloop 
    
            set x = x + 1 // Tăng x                                                                                                              
        endloop 
    endmethod 


    static method AddRandomDestructables takes integer x, integer y returns nothing 
        if GetRandomInt(0, 1) == 0 then 
            call CreateDestructable('ATtr', x, y, 270, GetRandomReal(1, 3), GetRandomInt(0, 4)) 
        else 
            call CreateDestructable('LTrc', x, y, 270, GetRandomReal(1, 3), GetRandomInt(0, 4)) 
        endif 
    endmethod 
endstruct 
    