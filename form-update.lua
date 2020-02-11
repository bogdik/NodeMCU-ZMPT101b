function updateForm(s)
    local s=parseurl(s)
    if s['type'] ~= nil then write_config('conf.cfg','type',s['type']) end
    if s['type']=='ap' then
    if s['ap_ssid'] ~= nil then write_config('conf.cfg','ap_ssid',s['ap_ssid']) else write_config('conf.cfg','ap_ssid','') end
    if s['ap_pass'] ~= nil then write_config('conf.cfg','ap_pass',s['ap_pass']) else write_config('conf.cfg','ap_pass','') end
    else
    if s['st_ssid'] ~= nil then write_config('conf.cfg','st_ssid',s['st_ssid']) else write_config('conf.cfg','st_ssid','') end
    if s['st_pass'] ~= nil then write_config('conf.cfg','st_pass',s['st_pass']) else write_config('conf.cfg','st_pass','') end
    if s['st_ip'] ~= nil then write_config('conf.cfg','st_ip',s['st_ip']) else write_config('conf.cfg','st_ip','')  end
    if s['st_mask'] ~= nil then write_config('conf.cfg','st_mask',s['st_mask']) else write_config('conf.cfg','st_mask','') end
    if s['st_gate'] ~= nil then write_config('conf.cfg','st_gate',s['st_gate']) else write_config('conf.cfg','st_gate','') end
    if s['st_dns'] ~= nil then write_config('conf.cfg','dns',s['st_dns']) else write_config('conf.cfg','dns','') end
    if s['mac'] ~= nil then write_config('conf.cfg','mac',s['mac']) else write_config('conf.cfg','mac','')  end
    end
end
