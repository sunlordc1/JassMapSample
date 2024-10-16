struct runtime
    static method new takes integer i, real timeout, boolean periodic, code func returns timer
        local timer t = CreateTimer()
        local integer id = GetHandleId(t)
        call SaveInteger(ht, id, 0, i)
        call SaveInteger(ht, id, 2, 0) //count <<
        call SaveReal(ht, id, 1, timeout)
        call TimerStart(t, timeout, periodic, func)
        return t
    endmethod
    static method tick takes nothing returns integer //trả về chu kì (số lần loop)
        return LoadInteger(ht, GetHandleId(GetExpiredTimer()), 2)
    endmethod
    static method get takes nothing returns integer //return this
        local integer id = GetHandleId(GetExpiredTimer())
        call SaveInteger(ht, id, 2, LoadInteger(ht, id, 2) + 1)
        return LoadInteger(ht, id, 0)
    endmethod
    static method count takes nothing returns real //trả về số giây theo số real
        local integer id = GetHandleId(GetExpiredTimer())
        return I2R(LoadInteger(ht, id, 2)) * LoadReal(ht, id, 1)
    endmethod
    static method end takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call PauseTimer(t)
        call FlushChildHashtable(ht, GetHandleId(t))
        call DestroyTimer(t)
        set t = null
    endmethod
    static method endx takes timer t returns nothing
        call PauseTimer(t)
        call FlushChildHashtable(ht, GetHandleId(t))
        call DestroyTimer(t)
        set t = null
    endmethod
endstruct