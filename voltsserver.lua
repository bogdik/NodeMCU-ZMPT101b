-- voltsserver.lua
print("Starting VoltsServer.lua...")

function startup() -- all the settings are here. Adjust the TCP port and voltage bias if needed
 bias=0.076 ledpin=0 on=0 off=1
 gpio.mode(ledpin, gpio.OUTPUT)
 timerv = tmr.create()
 timerm = tmr.create()
 timerm:register(1, tmr.ALARM_AUTO, getminmax)
 timerl = tmr.create()
 timerl:register(300000, tmr.ALARM_AUTO, logvolts)
 timerl:start() print("Logger started")
 led(off)
end

function getminmax() -- read min/max voltages from ZMPT101B
 v = adc.read(0) if v < min then min = v elseif v > max then max = v end
 i = i + 1 if i == 80 then timerm:stop() end -- stop after 80 samples
end

startup()

dofile("form.lua")
dofile("form2.lua")
dofile("form-update.lua")
dofile("form-update2.lua")

if not srv then -- prevents error in case the script is re-launched manually
 srv=net.createServer(net.TCP,120) -- start server
  srv:listen(888,function(c) -- listen for incoming connections (c)
  c:on("receive",function(c,d) -- function to execute when receiving first data
   local timers = tmr.create()
   if d:sub(1,19) =='GET /config2-update' then
     print("Update Form2")
     updateForm2('http://127.0.0.1'..spl(d))
     timers:alarm(500, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
       sender(c,getFormOk())
       c:close()
      end)
   elseif d:sub(1,19) =='GET /config1-update' then
     print("Update Form1")
     updateForm('http://127.0.0.1'..spl(d))
     timers:alarm(500, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
       sender(c,getFormOk())
       c:close()
      end)
   elseif d:sub(1,12) =='GET /config2' then
     timers:alarm(300, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
       sender(c,getForm2())
       c:close()
      end)
   elseif d:sub(1,11) =='GET /config' then
     timers:alarm(300, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
       sender(c,getForm())
       c:close()
     end)
   elseif d:sub(1,16) =='GET /favicon.ico' then
     timers:alarm(100, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
       sender(c,{})
       c:close()
     end)
   elseif d:sub(1,5) == "GET /" then
    getvolts("server") -- get the voltage and vstring formatted
    timers:alarm(200, tmr.ALARM_SINGLE, function() -- 200ms delay for timerm and timerv
     c:send("HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nServer:ESP \r\nContent-Length:"..vstring:len().." \r\nConnection: Close\r\n\r\n"..vstring)
     c:close() -- close connection
    end) -- timers
   end
   if d:sub(1,5) ~= "GET /" then c:close() return end 
  end) -- c:on receive (first)
 end) -- srv:listen
end -- if not srv

print("Server started")
cfg=read_config('conf.cfg')
if cfg['main']['type']=='ap' then
 ip,bc,gw=wifi.ap.getip()
else
 ip,bc,gw=wifi.sta.getip()
end
cfg=nil
print("To start/stop printing voltage to serial: Press FLASH button")
print("To retrieve current voltage: Send HTTP GET request to http://"..ip..":888/ ")
print("To access the LUA prompt: Telnet to IP "..ip.." port 888 and press [Enter]")
