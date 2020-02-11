function led(state) ledpin=0 gpio.write(ledpin,state) end -- turn led on or off

function getbutton() -- use flash button to toggle serial monitoring of voltage on or off
 if gpio.read(3) == 0 then  sw = (1 - sw) print("Switch "..sw) switch=switch+1 end
 if switch==4 then 
   print('Reset to default config')
   write_config('conf.cfg','type','ap')
   write_config('conf.cfg','ap_ssid','Volt AP')
   write_config('conf.cfg','ap_pass','')
   write_config('conf.cfg','type_calc','one')
   write_config('conf.cfg','coef','') 
   led(on)
   local timer = tmr.create()
   timer:alarm(5000, tmr.ALARM_SINGLE, function()
     node.restart()
    end)
 end  
 if sw == 1 and type(getvolts) ~= 'nil' then getvolts("button") end
end

function read_config(filename)
  filename = filename or ''
  assert(type(filename) == 'string')
  local ans,u,k,v,temp = {}
  if not file.exists(filename, "DATA" ) then 
    return {}
  end
  local f =  file.open(filename,'r')
  line = f:readline()
  u='main'
  ans[u] = {}
  while line do
    k,v = line:match('^(.+)=(.+)$')
    if k and v then
     ans[u][k] = string.gsub(v, "\n", "")
    end
    line = f:readline()
  end
  return ans
end

function write_config(filename,key,value)
  filename = filename or ''
  assert(type(filename) == 'string')
  local section='main'
  if key == nil or value == nil then return end
  local t = read_config(filename)
  if key:match '=' then
    error('An equals sign is not expected inside key')
  end
  if t[section] == nil then t[section]={} end
  t[section][key] = value
  local fo = file.open(filename,'w')
  for k,v in pairs(t) do
    fo:write('['..k..']\n')
    for k,v in pairs(v) do
      fo:write(k..'='..v..'\n')
    end
  end
  fo:close()
  return t
end


function urldecode(s)
  s = s:gsub('+', ' ')
       :gsub('%%(%x%x)', function(h)
                           return string.char(tonumber(h, 16))
                         end)
  return s
end

function parseurl(s)
  full = s:match('\?+(.+)')
  local ans = {}
  if full~=nil then
    for k,v in s:gmatch('[\?&]([^&=]+)=([^&=]+)' ) do
      ans[ k ] = urldecode(v)
    end
  end
  return ans
end

function spl(s)
  full = s:match('GET (.+) HTTP')
  return full
end

function sender(interface,string)
  --local form= string.format(string)
  interface:send("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: Close\r\n\r\n")
  while #string > 0 do 
    interface:send(string[1])
    table.remove(string, 1)
  end
  return
end
