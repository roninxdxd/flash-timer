;https://github.com/TLDRonin/flash-timer

clockSynchroniseTime = 30
 
TopLanerName   = Top Laner
JunglerName      = Jungler
MidLanerName   = Mid Laner
BotLanerName   = Bot Laner
SupportName     = Support
 
TTImer  := -1    ;Top Laner
JTimer   := -1    ;Jungler
MTimer  := -1    ;Mid Laner
BTimer   := -1    ;Bot Laner 
STimer   := -1    ;Support

;F1 = TopLaner
;F2 = Jungler
;F3 = MidLaner
;F4 = BotLaner
;F5 = Support

#Persistent
 
GameStartTime := -1
 
MakeTime(totalSeconds) {
    S := mod(totalSeconds, 60)
    M := mod((totalSeconds // 60), 60)
    H := mod((totalSeconds // 3600), 3600)
    
    zM := ""
    zS := ""
    zH := ""
    
    if M < 10
        zM := "0"
    if S < 10
        zS := "0"
    if H > 0
        zH := H . ":"
    
    return (zH . zM . M . ":" . zS . S)
}
 
TimeStamp(name, delay) {
    global GameStartTime
    globalSeconds := (A_TickCount - GameStartTime)//1000
    
    delaySeconds := globalSeconds + delay
    
    Chat(name . " Flash is up at around" . MakeTime(delaySeconds))
	 
}
 
ReportTimer(name, timer) {
    if timer = 0
    {
        Chat(name . " up")
    }
    else
    {
        Chat(name . " up in " . timer)
    }
}
 
Handle(name, scriptname, delay, timer) {
    TimeStamp(name, delay)
    if timer > -1
    {
        timername   = %scriptname%Timer
        timerdelay := (delay - timer) * 1000
        SetTimer, %timername%, -%timerdelay%
    }
}
 
~Home::
    Handle(TopLanerName, "TopLaner", 300, TTImer)
return
 
~PgUp::
    Handle(JunglerName, "Jungler", 300, JTimer)
return
 
~PgDn::
    Handle(MidLanerName, "MidLaner", 300, MTimer)
return
 
~End::
    Handle(BotLanerName, "BotLaner", 300, BTimer)
return
 
~Right::
    Handle(SupportName, "Support", 360, STimer)
return 
 
~SC00D::
    GameStartTime := A_TickCount - (clockSynchroniseTime * 1000)
return
 
 
~F10::
    MsgBox, 0x40000, FlashTimer, FlashTimer is no longer active. Press =/+ to reactivate, 2
    SetTimer, TopLanerTimer, Off
    SetTimer, JunglerTimer, Off
    SetTimer, MidLanerTimer, Off
    SetTimer, BotLanerTimer, Off
    SetTimer, SupportTimer, Off

return
 
Chat(msg) {
    Send {Enter}
    sleep 10
    Send %msg%
    sleep 10
    Send {Enter}
}
 
TopLanerTimer:
    ReportTimer(TopLanerName, TTImer)
return
 
JunglerTimer:
    ReportTimer(JunglerName, JTimer)ReportTimer 
return
 
MidLanerTimer:
    ReportTimer(MidLanerName, MTimer)
return
 
BotLanerTimer:
    ReportTimer(BotLanerName, BTimer)
return
 
SupportTimer:
    ReportTimer(SupportName, STimer)
return
 





