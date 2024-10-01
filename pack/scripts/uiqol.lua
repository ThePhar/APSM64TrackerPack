ScriptHost:AddWatchForCode("AP Change Entrance Spoil", "__setting_auto_ent", function()
    if SLOT_DATA ~= nil then
        areaReveal()
    end
end)
