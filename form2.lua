function getForm2()
    local cfg=read_config('conf.cfg')
    if cfg['main']['coef'] ~= nil then cfg_coef=cfg['main']['coef'] else cfg_coef='' end
    local table_zmpt = {}
    table_zmpt[#table_zmpt + 1]="<html><head></head><body>"
    table_zmpt[#table_zmpt + 1]="<form action='/config2-update' id='conf2'><table border='1' style='width:20px'><tr><td>Settings ZMPT101b</td></tr>"
    local type_calc1="<input type='radio' name='type_calc' value='one' "
    local type_calc2="<input type='radio' name='type_calc' value='two' "
    local type_calc3="<input type='radio' name='type_calc' value='three' "
    local type_calc4="<input type='radio' name='type_calc' value='four' "
    if cfg['main']['type_calc']=='one' then type_calc1=type_calc1.."checked" end
    if cfg['main']['type_calc']=='two' then type_calc2=type_calc2.."checked" end
    if cfg['main']['type_calc']=='three' then type_calc3=type_calc3.."checked" end
    if cfg['main']['type_calc']=='four' then type_calc3=type_calc3.."checked" end
    type_calc1=type_calc1..">"
    type_calc2=type_calc2..">"
    type_calc3=type_calc3..">"
    type_calc4=type_calc4..">"
    table_zmpt[#table_zmpt + 1]="<tr><td>Calculation type:<br>Type 1:"..type_calc1.." Type 2:"..type_calc2.." Type 3:"..type_calc3.." Type 4:"..type_calc4.."<br><br><br>"
    table_zmpt[#table_zmpt + 1]="Coefficient: <input type='text' name='coef' value='"..cfg_coef.."'></td></tr>"
    table_zmpt[#table_zmpt + 1]="</td></tr></table><br><button type='submit' form='conf2'>Save</button><br><br><a href='/config'>Config Main</a></form>"
    table_zmpt[#table_zmpt + 1]="After end config press RST button on device</body></html>"
    return table_zmpt
end
