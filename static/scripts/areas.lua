EntranceTable = {}

function EntranceTable:GetAreaStage(area)
    return EntranceTable["stage"][area]
end

EntranceTable["name"] = {
    ["BoB"]   = "Bob-omb Battlefield",
    ["WF"]    = "Whomp's Fortress",
    ["JRB"]   = "Jolly Roger Bay",
    ["CCM"]   = "Cool, Cool Mountain",
    ["BBH"]   = "Big Boo's Haunt",
    ["HMC"]   = "Hazy Maze Cave",
    ["LLL"]   = "Lethal Lava Land",
    ["SSL"]   = "Shifting Sand Land",
    ["DDD"]   = "Dire, Dire Docks",
    ["SL"]    = "Snowman's Land",
    ["WDW"]   = "Wet-Dry World",
    ["TTM"]   = "Tall, Tall Mountain",
    ["THIt"]  = "Tiny-Huge Island (Tiny)",
    ["THIh"]  = "Tiny-Huge Island (Huge)",
    ["TTC"]   = "Tick Tock Clock",
    ["RR"]    = "Rainbow Ride",
    ["BitDW"] = "Bowser in the Dark World",
    ["BitFS"] = "Bowser in the Fire Sea",
    ["BitS"]  = "Bowser in the Sky",
    ["TotWC"] = "Tower of the Wing Cap",
    ["CotMC"] = "Cavern of the Metal Cap",
    ["VCutM"] = "Vanish Cap under the Moat",
    ["PSS"]   = "Princess's Secret Slide",
    ["SA"]    = "Secret Aquarium",
    ["WMotR"] = "Wing Mario over the Rainbow",
}

EntranceTable["stage"] = {
    -- ID -> Acryonym
    [0]  = "unknown",
    [1]  = "BoB",
    [2]  = "WF",
    [3]  = "JRB",
    [4]  = "CCM",
    [5]  = "BBH",
    [6]  = "HMC",
    [7]  = "LLL",
    [8]  = "SSL",
    [9]  = "DDD",
    [10] = "SL",
    [11] = "WDW",
    [12] = "TTM",
    [13] = "THIt",
    [14] = "THIh",
    [15] = "TTC",
    [16] = "RR",
    [17] = "BitDW",
    [18] = "BitFS",
    [19] = "BitS",
    [20] = "PSS",
    [21] = "SA",
    [22] = "WMotR",
    [23] = "TotWC",
    [24] = "CotMC",
    [25] = "VCutM",

    -- Acryonym -> ID
    ["unknown"] = 0,
    ["BoB"]     = 1,
    ["WF"]      = 2,
    ["JRB"]     = 3,
    ["CCM"]     = 4,
    ["BBH"]     = 5,
    ["HMC"]     = 6,
    ["LLL"]     = 7,
    ["SSL"]     = 8,
    ["DDD"]     = 9,
    ["SL"]      = 10,
    ["WDW"]     = 11,
    ["TTM"]     = 12,
    ["THIt"]    = 13,
    ["THIh"]    = 14,
    ["TTC"]     = 15,
    ["RR"]      = 16,
    ["BitDW"]   = 17,
    ["BitFS"]   = 18,
    ["BitS"]    = 19,
    ["PSS"]     = 20,
    ["SA"]      = 21,
    ["WMotR"]   = 22,
    ["TotWC"]   = 23,
    ["CotMC"]   = 24,
    ["VCutM"]   = 25,
}

-- TODO: Rewrite this to not be as terrible?
function LoadStage(entrance)
    code = "__er_" .. entrance .. "_dst"
    ScriptHost:RemoveWatchForCode("Update Accessibility for " .. entrance)
    Tracker:FindObjectForCode(code).CurrentStage = EntranceTable["stage"][EntranceTable["accessible"][entrance]]
    ScriptHost:AddWatchForCode("Update Accessibility for " .. entrance, code, UpdateAccessibility)
end

function SetStage(entrance, stage)
    code = "__er_" .. entrance .. "_dst"
    ScriptHost:RemoveWatchForCode("Update Accessibility for " .. entrance)
    Tracker:FindObjectForCode(code).CurrentStage = EntranceTable["stage"][stage]
    ScriptHost:AddWatchForCode("Update Accessibility for " .. entrance, code, UpdateAccessibility)
end

function ResetEntrances()
    DefaultAll()
    ClearAll()
end

function ClearAll()
    SetStage("BoB", "unknown")
    SetStage("WF", "unknown")
    SetStage("JRB", "unknown")
    SetStage("CCM", "unknown")
    SetStage("BBH", "unknown")
    SetStage("HMC", "unknown")
    SetStage("LLL", "unknown")
    SetStage("SSL", "unknown")
    SetStage("DDD", "unknown")
    SetStage("SL", "unknown")
    SetStage("WDW", "unknown")
    SetStage("TTM", "unknown")
    SetStage("THIh", "unknown")
    SetStage("THIt", "unknown")
    SetStage("TTC", "unknown")
    SetStage("RR", "unknown")
    SetStage("BitDW", "unknown")
    SetStage("BitFS", "unknown")
    SetStage("BitS", "BitS")
    SetStage("TotWC", "unknown")
    SetStage("CotMC", "unknown")
    SetStage("VCutM", "unknown")
    SetStage("PSS", "unknown")
    SetStage("SA", "unknown")
    SetStage("WMotR", "unknown")
end

function DefaultSecrets()
    SetStage("BitDW", "BitDW")
    SetStage("BitFS", "BitFS")
    SetStage("BitS", "BitS")
    SetStage("TotWC", "TotWC")
    SetStage("CotMC", "CotMC")
    SetStage("VCutM", "VCutM")
    SetStage("PSS", "PSS")
    SetStage("SA", "SA")
    SetStage("WMotR", "WMotR")
end

function DefaultAll()
    SetStage("BoB", "BoB")
    SetStage("WF", "WF")
    SetStage("JRB", "JRB")
    SetStage("CCM", "CCM")
    SetStage("BBH", "BBH")
    SetStage("HMC", "HMC")
    SetStage("LLL", "LLL")
    SetStage("SSL", "SSL")
    SetStage("DDD", "DDD")
    SetStage("SL", "SL")
    SetStage("WDW", "WDW")
    SetStage("TTM", "TTM")
    SetStage("THIh", "THIh")
    SetStage("THIt", "THIt")
    SetStage("TTC", "TTC")
    SetStage("RR", "RR")
    SetStage("BitDW", "BitDW")
    SetStage("BitFS", "BitFS")
    SetStage("BitS", "BitS")
    SetStage("TotWC", "TotWC")
    SetStage("CotMC", "CotMC")
    SetStage("VCutM", "VCutM")
    SetStage("PSS", "PSS")
    SetStage("SA", "SA")
    SetStage("WMotR", "WMotR")
end

ScriptHost:AddWatchForCode("Clear All", "__er_clear", ClearAll)
ScriptHost:AddWatchForCode("Default All", "__er_reset_all", DefaultAll)
ScriptHost:AddWatchForCode("Default Secrets", "__er_reset_secret", DefaultSecrets)

ScriptHost:AddWatchForCode("AP Change Entrance Spoil", "__setting_auto_ent", function()
    if SLOT_DATA ~= nil then
        areaReveal()
    end
end)
