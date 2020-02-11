function updateForm2(s)
    local s=parseurl(s)
    if s['type_calc'] ~= nil then write_config('conf.cfg','type_calc',s['type_calc']) else write_config('conf.cfg','type_calc','one') end
    if s['coef'] ~= nil then write_config('conf.cfg','coef',s['coef']) else write_config('conf.cfg','coef','') end
end
