HUNDRED_COIN_LOCATIONS = {
    "__location_item_3626006",
    "__location_item_3626013",
    "__location_item_3626020",
    "__location_item_3626027",
    "__location_item_3626034",
    "__location_item_3626041",
    "__location_item_3626048",
    "__location_item_3626055",
    "__location_item_3626062",
    "__location_item_3626069",
    "__location_item_3626076",
    "__location_item_3626083",
    "__location_item_3626090",
    "__location_item_3626097",
    "__location_item_3626104",
}

BUDDY_LOCATIONS = {
    "__location_item_3626200",
    "__location_item_3626201",
    "__location_item_3626202",
    "__location_item_3626203",
    "__location_item_3626207",
    "__location_item_3626209",
    "__location_item_3626210",
    "__location_item_3626211",
    "__location_item_3626212",
    "__location_item_3626214",
}

ONE_UP_LOCATIONS = {
    "__location_item_3626215",
    "__location_item_3626216",
    "__location_item_3626217",
    "__location_item_3626218",
    "__location_item_3626219",
    "__location_item_3626220",
    "__location_item_3626221",
    "__location_item_3626222",
    "__location_item_3626223",
    "__location_item_3626224",
    "__location_item_3626225",
    "__location_item_3626226",
    "__location_item_3626227",
    "__location_item_3626228",
    "__location_item_3626229",
    "__location_item_3626230",
    "__location_item_3626231",
    "__location_item_3626232",
    "__location_item_3626233",
    "__location_item_3626234",
    "__location_item_3626235",
    "__location_item_3626236",
    "__location_item_3626237",
    "__location_item_3626238",
    "__location_item_3626239",
    "__location_item_3626240",
    "__location_item_3626241",
    "__location_item_3626242",
    "__location_item_3626243",
}

ScriptHost:AddWatchForCode("Toggle 100 Coins", "__setting_100", function()
    local is_active = Tracker:FindObjectForCode("__setting_100").Active
    for _, location in ipairs(HUNDRED_COIN_LOCATIONS) do
        Tracker:FindObjectForCode(location).Active = not is_active
    end
end)

ScriptHost:AddWatchForCode("Toggle Buddies", "__setting_BB", function()
    local is_active = Tracker:FindObjectForCode("__setting_BB").Active
    for _, location in ipairs(BUDDY_LOCATIONS) do
        Tracker:FindObjectForCode(location).Active = not is_active
    end
end)

ScriptHost:AddWatchForCode("Toggle 1-Ups", "__setting_1UB", function()
    local is_active = Tracker:FindObjectForCode("__setting_1UB").Active
    for _, location in ipairs(ONE_UP_LOCATIONS) do
        Tracker:FindObjectForCode(location).Active = not is_active
    end
end)
