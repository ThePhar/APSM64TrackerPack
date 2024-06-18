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
    [20] = "totwc",
    [21] = "cotmc",
    [22] = "vcutm",
    [23] = "pss",
    [24] = "sa",
    [25] = "wmotr",

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
    ["totwc"]   = 20,
    ["cotmc"]   = 21,
    ["vcutm"]   = 22,
    ["pss"]     = 23,
    ["sa"]      = 24,
    ["wmotr"]   = 25,
}

--function EntranceTable:Initialize()
--    EntranceTable["accessible"] = {
--        ["bob"]    = "__null__",  -- 1
--        ["wf"]     = "__null__",  -- 2
--        ["jrb"]    = "__null__",  -- 3
--        ["ccm"]    = "__null__",  -- 4
--        ["bbh"]    = "__null__",  -- 5
--        ["hmc"]    = "__null__",  -- 6
--        ["lll"]    = "__null__",  -- 7
--        ["ssl"]    = "__null__",  -- 8
--        ["ddd"]    = "__null__",  -- 9
--        ["sl"]     = "__null__",  -- 10
--        ["wdw"]    = "__null__",  -- 11
--        ["ttm"]    = "__null__",  -- 12
--        ["thih"]   = "__null__",  -- 13
--        ["thit"]   = "__null__",  -- 14
--        ["ttc"]    = "__null__",  -- 15
--        ["rr"]     = "__null__",  -- 16
--        ["bitdw"]  = "__null__",  -- 17
--        ["bitfs"]  = "__null__",  -- 18
--        ["totwc"]  = "__null__",  -- 19
--        ["cotmc"]  = "__null__",  -- 20
--        ["vcutm"]  = "__null__",  -- 21
--        ["pss"]    = "__null__",  -- 22
--        ["sa"]     = "__null__",  -- 23
--        ["wmotr"]  = "__null__",  -- 24
--    }
--end

----- @param code string
--local function UpdateAccessibility(code)
--    local er_setting = Tracker:FindObjectForCode("__setting_ER").CurrentStage
--    local entrance = code:gsub("__er_", ""):gsub("_dst", "")
--    if er_setting == 1 then
--    	if (
--            entrance == "bitdw" or
--            entrance == "bitfs" or
--            entrance == "totwc" or
--            entrance == "cotmc" or
--            entrance == "vcutm" or
--            entrance == "pss" or
--            entrance == "sa" or
--            entrance == "wmotr"
--    	) then
--        	SetStage(entrance, entrance)
--    		return
--    	end
--    end
--
--    if er_setting == 0 then
--        SetStage(entrance, entrance)
--    	return
--    end
--
--    local item = Tracker:FindObjectForCode(code)
--    EntranceTable["accessible"][entrance] = EntranceTable["stage"][item.CurrentStage]
--end
--
--EntranceTable:Initialize()
--for stage, _ in pairs(EntranceTable["accessible"]) do
--	ScriptHost:AddWatchForCode("Update Accessibility for " .. stage, "__er_" .. stage .. "_dst", UpdateAccessibility)
--end
--
---- Prevent unclearing of unknowns.
--function UnclearUnknown(code)
--    --- @type JsonItem
--    local item = Tracker:FindObjectForCode(code)
--    item.Active = false
--end
--
--ScriptHost:AddWatchForCode("Unclear Unknowns", "__location_item_null", UnclearUnknown)

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



--function LoadStage(entrance)
--    code = "__er_" .. entrance .. "_dst"
--    ScriptHost:RemoveWatchForCode("Update Accessibility for " .. entrance)
--    Tracker:FindObjectForCode(code).CurrentStage = EntranceTable["stage"][EntranceTable["accessible"][entrance]]
--    ScriptHost:AddWatchForCode("Update Accessibility for " .. entrance, code, UpdateAccessibility)
--end
--
--function SetStage(entrance, stage)
--    code = "__er_" .. entrance .. "_dst"
--    ScriptHost:RemoveWatchForCode("Update Accessibility for " .. entrance)
--    Tracker:FindObjectForCode(code).CurrentStage = EntranceTable["stage"][stage]
--    ScriptHost:AddWatchForCode("Update Accessibility for " .. entrance, code, UpdateAccessibility)
--end
--
--function ResetEntrances()
--    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 1 then
--        SetStage("bitdw", "bitdw")
--        SetStage("bitfs", "bitfs")
--        SetStage("totwc", "totwc")
--        SetStage("cotmc", "cotmc")
--        SetStage("vcutm", "vcutm")
--        SetStage("pss", "pss")
--        SetStage("sa", "sa")
--        SetStage("wmotr", "wmotr")
--
--        LoadStage("bob")
--        LoadStage("wf")
--        LoadStage("jrb")
--        LoadStage("ccm")
--        LoadStage("bbh")
--        LoadStage("hmc")
--        LoadStage("lll")
--        LoadStage("ssl")
--        LoadStage("ddd")
--        LoadStage("sl")
--        LoadStage("wdw")
--        LoadStage("ttm")
--        LoadStage("thih")
--        LoadStage("thit")
--        LoadStage("ttc")
--        LoadStage("rr")
--    end
--
--    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 0 then
--        SetStage("bob", "bob")
--        SetStage("wf", "wf")
--        SetStage("jrb", "jrb")
--        SetStage("ccm", "ccm")
--        SetStage("bbh", "bbh")
--        SetStage("hmc", "hmc")
--        SetStage("lll", "lll")
--        SetStage("ssl", "ssl")
--        SetStage("ddd", "ddd")
--        SetStage("sl", "sl")
--        SetStage("wdw", "wdw")
--        SetStage("ttm", "ttm")
--        SetStage("thih", "thih")
--        SetStage("thit", "thit")
--        SetStage("ttc", "ttc")
--        SetStage("rr", "rr")
--        SetStage("bitdw", "bitdw")
--        SetStage("bitfs", "bitfs")
--        SetStage("totwc", "totwc")
--        SetStage("cotmc", "cotmc")
--        SetStage("vcutm", "vcutm")
--        SetStage("pss", "pss")
--        SetStage("sa", "sa")
--        SetStage("wmotr", "wmotr")
--    end
--
--    if Tracker:FindObjectForCode("__setting_ER").CurrentStage == 2 then
--        LoadStage("bob")
--        LoadStage("wf")
--        LoadStage("jrb")
--        LoadStage("ccm")
--        LoadStage("bbh")
--        LoadStage("hmc")
--        LoadStage("lll")
--        LoadStage("ssl")
--        LoadStage("ddd")
--        LoadStage("sl")
--        LoadStage("wdw")
--        LoadStage("ttm")
--        LoadStage("thih")
--        LoadStage("thit")
--        LoadStage("ttc")
--        LoadStage("rr")
--        LoadStage("bitdw")
--        LoadStage("bitfs")
--        LoadStage("totwc")
--        LoadStage("cotmc")
--        LoadStage("vcutm")
--        LoadStage("pss")
--        LoadStage("sa")
--        LoadStage("wmotr")
--    end
--end
--
--ScriptHost:AddWatchForCode("ResetEntrances", "__setting_ER", ResetEntrances)
--ResetEntrances()
