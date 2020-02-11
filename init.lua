-- init.lua for Volts Server
switch=0
sw=0
dofile("config.lua")
cfg=read_config('conf.cfg')
timerb = tmr.create()
timerb:register(2000, tmr.ALARM_AUTO, getbutton)
timerb:start() print("Switch started")


if cfg['main']==nil then 
  write_config('conf.cfg','type','ap')
  cfg=read_config('conf.cfg')
end
if cfg['main']['type']==nil then
  write_config('conf.cfg','type','ap')
  cfg=read_config('conf.cfg')
end
if cfg['main']['type']=='st' and cfg['main']['st_ssid'] ~= nil then 
  print("Use Station")
  wifi.setmode(wifi.STATION)
  if cfg['main']['mac'] ~= nil and cfg['main']['mac'] ~= '' then wifi.sta.setmac(cfg['main']['mac']) end
  if cfg['main']['st_ip'] ~= nil and cfg['main']['st_mask'] ~= nil and cfg['main']['st_gate'] ~= nil and cfg['main']['st_ip'] ~= '' and cfg['main']['st_mask'] ~= '' and cfg['main']['st_gate'] ~= '' then
    wifi.sta.setip({ip=cfg['main']['st_ip'], netmask=cfg['main']['st_mask'], gateway=cfg['main']['st_gate']})
  end
  local cfg_st={}
  cfg_st['ssid']=cfg['main']['st_ssid']
  if cfg['main']['st_pass'] ~= nil and cfg['main']['st_pass'] ~= '' then cfg_st['pwd']=cfg['main']['st_pass'] end
  wifi.sta.config(cfg_st)
  if cfg['main']['dns'] ~= nil and cfg['main']['dns'] ~= '' then net.dns.setdnsserver(cfg['main']['dns'],0) end
end
if cfg['main']['type']=='ap' then
  print("Use AP")
  local cfg_ap={}
  if cfg['main']['ap_ssid'] ~= nil and cfg['main']['ap_ssid']  ~='' then 
    cfg_ap['ssid']=cfg['main']['ap_ssid']
  else
    cfg_ap['ssid']='Volt AP'
  end
  if cfg['main']['ap_pass'] ~= nil and cfg['main']['ap_pass'] ~='' then cfg_ap['pwd']=cfg['main']['ap_pass'] end
  wifi.setmode(wifi.SOFTAP)
  wifi.ap.config(cfg_ap)
end

if cfg['main']['type']=='st' then
    cfg=nil
    local ctimer = tmr.create()
    --ctimer:alarm(1000, tmr.ALARM_SINGLE, function() -- main loop for connecting to AP
    ctimer:alarm(1000, tmr.ALARM_AUTO, function() -- main loop for connecting to AP
     local wfs = wifi.sta.status() -- get wifi status
     if wfs < 5 then -- less than 5 means it's not connected yet
      if wfs == 1 then
       print("Connecting to AP...") -- 1 is okay, just takes a few seconds
      else
       print("Connection status:",wfs) -- 0, 2, 3, 4 = idle, wrong pwd, ap not found, failure
      end -- if wfs < 5
     else
      print("Connected")
      print("IP:",wifi.sta.getip())
      net.dns.resolve("pool.ntp.org", function(sk, ntpip) -- get IP of nearest NTP server
       if (ntpip == nil or sntp == nil) then
        print("Failed to get ntp server IP!")
       else
        print("Sync ntp",tmr.now()) -- start time
        sntp.sync(ntpip)

        print("Ntp done",tmr.now()) -- end time, tells how long it took to sync (mainly for debugging)
        local ttimer = tmr.create()
        ttimer:alarm(200, tmr.ALARM_SINGLE, function() -- 200ms delay 
         local ue,um = rtctime.get()
         print(string.format("Got time %s from ntp server %s",ue,ntpip))
        ntpip=nil
        sntp=nil
        end) -- tmr.alarm 6
       end -- if ntpip == nil
      end) -- dns resolve
      if (wifi.sta.sethostname("ESP8266LUA")) then -- optional
       print("Hostname set to ESP8266LUA")
      else
       print("Hostname not set")
      end -- wifi.sta.sethostname
      local runtimer = tmr.create()
      runtimer:alarm(1000, tmr.ALARM_SINGLE, function()
       dofile("config2.lua")
       dofile("voltsserver.lua") -- launch main program
      end)
      ctimer:stop(0) -- connected to AP, stop timer/loop
     end -- if/else (wfs==5)
    end) -- tmr.alarm 0
else
   cfg=nil
   local runtimer = tmr.create()
   runtimer:alarm(1000, tmr.ALARM_SINGLE, function()
       dofile("config2.lua")
       dofile("voltsserver.lua") -- launch main program
    end)
end
