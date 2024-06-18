EntranceTable = {}

function EntranceTable:GetAreaStage(area)
    return EntranceTable["stage"][area]
end

EntranceTable["name"] = {
    ["bob"]   = "Bob-omb Battlefield",
    ["wf"]    = "Whomp's Fortress",
    ["jrb"]   = "Jolly Roger Bay",
    ["ccm"]   = "Cool, Cool Mountain",
    ["bbh"]   = "Big Boo's Haunt",
    ["hmc"]   = "Hazy Maze Cave",
    ["lll"]   = "Lethal Lava Land",
    ["ssl"]   = "Shifting Sand Land",
    ["ddd"]   = "Dire, Dire Docks",
    ["sl"]    = "Snowman's Land",
    ["wdw"]   = "Wet-Dry World",
    ["ttm"]   = "Tall, Tall Mountain",
    ["thit"]  = "Tiny-Huge Island (Tiny)",
    ["thih"]  = "Tiny-Huge Island (Huge)",
    ["ttc"]   = "Tick Tock Clock",
    ["rr"]    = "Rainbow Ride",
    ["bitdw"] = "Bowser in the Dark World",
    ["bitfs"] = "Bowser in the Fire Sea",
    ["bits"]  = "Bowser in the Sky",
    ["totwc"] = "Tower of the Wing Cap",
    ["cotmc"] = "Cavern of the Metal Cap",
    ["vcutm"] = "Vanish Cap under the Moat",
    ["pss"]   = "Princess's Secret Slide",
    ["sa"]    = "Secret Aquarium",
    ["wmotr"] = "Wing Mario over the Rainbow",
}

EntranceTable["stage"] = {
    -- ID -> Acryonym
    [0]  = "unknown",
    [1]  = "bob",
    [2]  = "wf",
    [3]  = "jrb",
    [4]  = "ccm",
    [5]  = "bbh",
    [6]  = "hmc",
    [7]  = "lll",
    [8]  = "ssl",
    [9]  = "ddd",
    [10] = "sl",
    [11] = "wdw",
    [12] = "ttm",
    [13] = "thih",
    [14] = "thit",
    [15] = "ttc",
    [16] = "rr",
    [17] = "bitdw",
    [18] = "bitfs",
    [19] = "bits",
    [20] = "pss",
    [21] = "sa",
    [22] = "wmotr",
    [23] = "totwc",
    [24] = "cotmc",
    [25] = "vcutm",

    -- Acryonym -> ID
    ["unknown"] = 0,
    ["bob"]     = 1,
    ["wf"]      = 2,
    ["jrb"]     = 3,
    ["ccm"]     = 4,
    ["bbh"]     = 5,
    ["hmc"]     = 6,
    ["lll"]     = 7,
    ["ssl"]     = 8,
    ["ddd"]     = 9,
    ["sl"]      = 10,
    ["wdw"]     = 11,
    ["ttm"]     = 12,
    ["thih"]    = 13,
    ["thit"]    = 14,
    ["ttc"]     = 15,
    ["rr"]      = 16,
    ["bitdw"]   = 17,
    ["bitfs"]   = 18,
    ["bits"]    = 19,
    ["pss"]     = 20,
    ["sa"]      = 21,
    ["wmotr"]   = 22,
    ["totwc"]   = 23,
    ["cotmc"]   = 24,
    ["vcutm"]   = 25,
}

----- @param code string
local function UpdateAccessibility(code)
    local er_setting = Tracker:FindObjectForCode("__setting_ER").CurrentStage
    local entrance = code:gsub("__er_", ""):gsub("_dst", "")
    if er_setting == 1 then
    	if (
            entrance == "bitdw" or
            entrance == "bitfs" or
            entrance == "totwc" or
            entrance == "cotmc" or
            entrance == "vcutm" or
            entrance == "pss" or
            entrance == "sa" or
            entrance == "wmotr"
    	) then
        	SetStage(entrance, entrance)
    		return
    	end
    end

    if er_setting == 0 then
        SetStage(entrance, entrance)
    	return
    end
end

-- TODO Clean up
function IsUnknownDestination(entrance)
    return Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == 0
end

function IsSelectedDestination(area, entrance)
    -- Special handling since there's multiple THI entrances.
    if area == "thi" then
    	return (
    	    Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage("thih") or
            Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage("thit")
    	)
    end

    return Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage(area)
end

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
    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 2 then
        SetStage("bob", "unknown")
        SetStage("wf", "unknown")
        SetStage("jrb", "unknown")
        SetStage("ccm", "unknown")
        SetStage("bbh", "unknown")
        SetStage("hmc", "unknown")
        SetStage("lll", "unknown")
        SetStage("ssl", "unknown")
        SetStage("ddd", "unknown")
        SetStage("sl", "unknown")
        SetStage("wdw", "unknown")
        SetStage("ttm", "unknown")
        SetStage("thih", "unknown")
        SetStage("thit", "unknown")
        SetStage("ttc", "unknown")
        SetStage("rr", "unknown")
        SetStage("bitdw", "unknown")
        SetStage("bitfs", "unknown")
        SetStage("bits", "bits")
        SetStage("totwc", "unknown")
        SetStage("cotmc", "unknown")
        SetStage("vcutm", "unknown")
        SetStage("pss", "unknown")
        SetStage("sa", "unknown")
        SetStage("wmotr", "unknown")
    end

    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 1 then
        SetStage("bitdw", "bitdw")
        SetStage("bitfs", "bitfs")
        SetStage("bits", "bits")
        SetStage("totwc", "totwc")
        SetStage("cotmc", "cotmc")
        SetStage("vcutm", "vcutm")
        SetStage("pss", "pss")
        SetStage("sa", "sa")
        SetStage("wmotr", "wmotr")

        SetStage("bob", "unknown")
        SetStage("wf", "unknown")
        SetStage("jrb", "unknown")
        SetStage("ccm", "unknown")
        SetStage("bbh", "unknown")
        SetStage("hmc", "unknown")
        SetStage("lll", "unknown")
        SetStage("ssl", "unknown")
        SetStage("ddd", "unknown")
        SetStage("sl", "unknown")
        SetStage("wdw", "unknown")
        SetStage("ttm", "unknown")
        SetStage("thih", "unknown")
        SetStage("thit", "unknown")
        SetStage("ttc", "unknown")
        SetStage("rr", "unknown")
    end

    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 0 then
        SetStage("bob", "bob")
        SetStage("wf", "wf")
        SetStage("jrb", "jrb")
        SetStage("ccm", "ccm")
        SetStage("bbh", "bbh")
        SetStage("hmc", "hmc")
        SetStage("lll", "lll")
        SetStage("ssl", "ssl")
        SetStage("ddd", "ddd")
        SetStage("sl", "sl")
        SetStage("wdw", "wdw")
        SetStage("ttm", "ttm")
        SetStage("thih", "thih")
        SetStage("thit", "thit")
        SetStage("ttc", "ttc")
        SetStage("rr", "rr")
        SetStage("bitdw", "bitdw")
        SetStage("bitfs", "bitfs")
        SetStage("bits", "bits")
        SetStage("totwc", "totwc")
        SetStage("cotmc", "cotmc")
        SetStage("vcutm", "vcutm")
        SetStage("pss", "pss")
        SetStage("sa", "sa")
        SetStage("wmotr", "wmotr")
    end
end

function Initialize()
    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 1 then
        SetStage("bitdw", "bitdw")
        SetStage("bitfs", "bitfs")
        SetStage("bits", "bits")
        SetStage("totwc", "totwc")
        SetStage("cotmc", "cotmc")
        SetStage("vcutm", "vcutm")
        SetStage("pss", "pss")
        SetStage("sa", "sa")
        SetStage("wmotr", "wmotr")
    end

    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 0 then
        SetStage("bob", "bob")
        SetStage("wf", "wf")
        SetStage("jrb", "jrb")
        SetStage("ccm", "ccm")
        SetStage("bbh", "bbh")
        SetStage("hmc", "hmc")
        SetStage("lll", "lll")
        SetStage("ssl", "ssl")
        SetStage("ddd", "ddd")
        SetStage("sl", "sl")
        SetStage("wdw", "wdw")
        SetStage("ttm", "ttm")
        SetStage("thih", "thih")
        SetStage("thit", "thit")
        SetStage("ttc", "ttc")
        SetStage("rr", "rr")
        SetStage("bitdw", "bitdw")
        SetStage("bitfs", "bitfs")
        SetStage("bits", "bits")
        SetStage("totwc", "totwc")
        SetStage("cotmc", "cotmc")
        SetStage("vcutm", "vcutm")
        SetStage("pss", "pss")
        SetStage("sa", "sa")
        SetStage("wmotr", "wmotr")
    end
end

ScriptHost:AddWatchForCode("ResetEntrances", "__setting_ER", ResetEntrances)
Initialize()
