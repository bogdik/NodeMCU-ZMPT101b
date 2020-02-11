function logvolts() getvolts("logger") end -- log to flash ram
function getvolts(target) -- get data and format string for specified target 
 i=0 min=2000 max=0 v=0 limit=0
 V=0
 vstring=" 00.00 No data\n" lstring="-\t-\t-\t-\t-\n" mstring=vstring
 led(on) -- turn led on to show activity
 timerm:start(timerm) -- get min/max
 local coef=2.4
 timerv:alarm(100, tmr.ALARM_SINGLE, function() -- wait 100ms to let getminmax() finish first
  local trun,tmode = timerm:state() -- get timerm state to see if it finished running
  if (trun == false) then -- it's not running anymore so we can use the min/max values
   local cfg=read_config('conf.cfg')
   if cfg['main']['coef'] ~= nil and cfg['main']['coef']~='' then coef=cfg['main']['coef'] end
   local vx=(max-min)
   if cfg['main']['type_calc']=='one' then
     V=((0.00000412*vx*vx*vx)-(0.000857*vx*vx)+(coef*vx)-3.198)
   elseif cfg['main']['type_calc']=='four' then
     V=(-0.00000004888*vx*vx*vx*vx+ 0.00002986*vx*vx*vx-0.005183*vx*vx+coef*vx-6.085)
   else
     V=coef*vx-8.35
   end
   local Vms=V/(2*math.sqrt(2))
   if cfg['main']['type_calc']=='three' then Vms=((((max/math.sqrt(2))-420.76)/-90.24)*-210.2)+210.2 end
   if (vx<=20) then Vms=0 end
   if (target == "server") then -- format string for http client
    vstring = string.format("{ \"Timestamp\": %d, \"Volts\": %05.2f, \"Min\": %0.3f, \"Max\": %0.3f, \"Delta\": %d, \"NewV\": %05.2f }",rtctime.get(),(max-min)*bias*10,min/1000,max/1000,max-min,Vms)
    -- I wish I could use c:send() c:close() here but LUA complains :-/
   else -- default target
    mstring = string.format("Min: %0.3f Max: %0.3f D: %03d = %05.2fV New: %03d",min/1000,max/1000,max-min,(max-min)*bias*10,Vms)
    print(mstring) -- output on serial (or telnet console)
   end -- if target
   led(off)
   timerv:stop()
  else
   limit = limit + 1
   if limit == 10 then limit = 0
    led(off)
    print("timeout")
    timerm:stop()
    timerv:stop()
   end
  end
 end)
end
