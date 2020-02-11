function getForm() 
    local cfg=read_config('conf.cfg')
    local type_ap="<input type='radio' name='type' value='ap' "
    local type_st="<input type='radio' name='type' value='st' "
    if cfg['main']['type']=='ap' then type_ap=type_ap.."checked" else type_st=type_st.."checked" end
    type_ap=type_ap..">"
    type_st=type_st..">"
    local cfg_ap_ssid='' cfg_ap_pass='' cfg_st_ssid=''  cfg_st_pass='' cfg_st_ip=''  cfg_st_mask='' cfg_st_gate='' cfg_st_dns='' cfg_st_mac='' 
    if cfg['main']['ap_ssid'] ~= nil then cfg_ap_ssid=cfg['main']['ap_ssid'] end
    if cfg['main']['ap_pass'] ~= nil then cfg_ap_pass=cfg['main']['ap_pass'] end
    if cfg['main']['st_ssid'] ~= nil then cfg_st_ssid=cfg['main']['st_ssid'] end
    if cfg['main']['st_pass'] ~= nil then cfg_st_pass=cfg['main']['st_pass'] end
    if cfg['main']['st_ip'] ~= nil then cfg_st_ip=cfg['main']['st_ip'] end
    if cfg['main']['st_mask'] ~= nil then cfg_st_mask=cfg['main']['st_mask'] end
    if cfg['main']['st_gate'] ~= nil then cfg_st_gate=cfg['main']['st_gate'] end
    if cfg['main']['dns'] ~= nil then cfg_st_dns=cfg['main']['dns'] end
    local table_connect_tb = {}
    table_connect_tb[#table_connect_tb + 1]="<html><head></head><body><form action='/config1-update' id='conf1'>Type connect:"..type_ap.."Acces point "..type_st.."Station<br>"
    table_connect_tb[#table_connect_tb + 1]="<table border='1' style='width:20px'>"
    if cfg['main']['type']=='ap' then 
    table_connect_tb[#table_connect_tb + 1]="<tr><td>For Acces Point</td></tr><tr><td>SSID *: <input type='text' placeholder='Def \"Volt AP\"' value='"..cfg_ap_ssid.."' name='ap_ssid'><br>"
    table_connect_tb[#table_connect_tb + 1]="Pass: <input type='text' name='ap_pass' value='"..cfg_ap_pass.."'></td></tr>"
    else
    table_connect_tb[#table_connect_tb + 1]="<tr><td>For Station</td></tr>"
    table_connect_tb[#table_connect_tb + 1]="<tr><td>SSID Station *: <input type='text' value='"..cfg_st_ssid.."' name='st_ssid'><br>"
    table_connect_tb[#table_connect_tb + 1]="Pass Station: <input type='text' name='st_pass' value='"..cfg_st_pass.."'><br>"
    table_connect_tb[#table_connect_tb + 1]="If you not use DHCP:<br>IP *: <input type='text' value='"..cfg_st_ip.."' name='st_ip'><br>"
    table_connect_tb[#table_connect_tb + 1]="Mask *: <input type='text' name='st_mask' value='"..cfg_st_mask.."'>"
    table_connect_tb[#table_connect_tb + 1]="Gate *: <input type='text' value='"..cfg_st_gate.."' name='st_gate'><br>DNS *: <input type='text' name='st_dns' value='"..cfg_st_dns.."'>"
    end
    table_connect_tb[#table_connect_tb + 1]="</td></tr></table><br><button type='submit' form='conf1'>Save</button><br><br><a href='/config2'>Config ZMPT101b</a></form>"
    table_connect_tb[#table_connect_tb + 1]="After end config press RST button on device</body></html>"
    return table_connect_tb
end

function getFormOk()
   local ok = {}
   ok[#ok + 1]="<html><center>Done<br><a href='/config2'>Back</a></center></html>"
   return ok
end
