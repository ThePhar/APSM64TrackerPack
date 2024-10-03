---@return number
function MoveAccessibility()
    if Tracker:FindObjectForCode("__setting_SM").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

---@return number
function CapsAccessibility()
    if Tracker:FindObjectForCode("__setting_SC").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

---@return number
function CannAccessibility()
    if Tracker:FindObjectForCode("__setting_SN").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

---@param cap string The cap shorthand.
---@return boolean Returns true if cap is unlocked.
function HasCap(cap)
    local cap_code_lookup = {
        ["WC"] = "item__cm_wc", -- Wing Cap
        ["MC"] = "item__cm_mc", -- Metal Cap
        ["VC"] = "item__cm_vc", -- Vanish Cap
    }

    local item = Tracker:FindObjectForCode(cap_code_lookup[cap])
    if item ~= nil and item.Active then
        return true
    end

    return false
end

---@param course string The course shorthand.
---@return boolean Returns true if cannon is unlocked (or unlock-able).
function HasCannon(course)
    -- Assume we have access if buddies are not randomized.
    if not Tracker:FindObjectForCode("__setting_BB").Active then
    	return true
    end

    local cannon_code_lookup = {
        ["BoB"] = "item__cann_bob",
        ["WF"]  = "item__cann_wf",
        ["JRB"] = "item__cann_jrb",
        ["CCM"] = "item__cann_ccm",
        ["SSL"] = "item__cann_ssl",
        ["SL"]  = "item__cann_sl",
        ["WDW"] = "item__cann_wdw",
        ["TTM"] = "item__cann_ttm",
        ["THI"] = "item__cann_thi",
        ["RR"]  = "item__cann_rr",
    }

    local item = Tracker:FindObjectForCode(cannon_code_lookup[course])
    if item ~= nil and item.Active then
    	return true
    end

    return false
end

---@param moves string A string of moves, delimited by `/` characters.
---@return boolean Returns true if any given move is accessible.
function HasMoves(moves)
    -- We always have the moves if MoveRando is disabled.
    if not Tracker:FindObjectForCode("__setting_MV").Active then
    	return true
    end

    local move_code_lookup = {
        ["TJ"] = "item__cm_tj", -- Triple Jump
        ["LJ"] = "item__cm_lj", -- Long Jump
        ["BF"] = "item__cm_bf", -- Backflip
        ["SF"] = "item__cm_sf", -- Sideflip
        ["WK"] = "item__cm_wk", -- Wall Kick
        ["DV"] = "item__cm_dv", -- Dive
        ["GP"] = "item__cm_gp", -- Ground Pound
        ["KI"] = "item__cm_ki", -- Kick
        ["CL"] = "item__cm_cl", -- Climb
        ["LG"] = "item__cm_lg", -- Long
    }

    for move in moves:gmatch("([^/]+)/?") do
    	local item = Tracker:FindObjectForCode(move_code_lookup[move])
    	if item ~= nil and item.Active then
    		return true
    	end
    end

    return false
end

---@return boolean
function NoAreaRandomizer()
    for stage, _ in pairs(EntranceTable["name"]) do
        local stage_idx = Tracker:FindObjectForCode("__er_" .. stage .. "_dst").CurrentStage
        if EntranceTable["stage"][stage_idx] ~= stage then
            return false
        end
    end

    return true
end

---@return boolean Returns true if player can access HMC (only needed for access to CotMC entrance).
function CanAccessHMC()
    local accessibility_level = AccessibilityLevel.None
    for entrance, entrance_name in pairs(EntranceTable["name"]) do
        local setting = Tracker:FindObjectForCode("__er_" .. entrance .. "_dst")
        if setting ~= nil and setting.CurrentStage == 6 then  -- HMC == 6
            local location = "@" .. entrance_name .. " Entrance"
        	local level = Tracker:FindObjectForCode(location).AccessibilityLevel
        	if level ~= nil and level > accessibility_level then
        		accessibility_level = level
        	end
        end
    end

    return accessibility_level
end

---@param key string The **U**pstairs key or **B**asement key.
---@return boolean
function HasKey(key)
    if key == "U" then
        return Tracker:FindObjectForCode("item__key").CurrentStage & 2 == 2
    end

    if key == "B" then
        return Tracker:FindObjectForCode("item__key").CurrentStage & 1 == 1
    end

    return false
end

---@param qty string | number A quantity of stars or a special keyword that depends on other settings.
---@return boolean
function HasStars(qty)
    local count = tonumber(qty)
    if count ~= nil then
        return Tracker:ProviderCountForCode("item__star") >= count
    end

    -- Special keyword
    local tens = (Tracker:FindObjectForCode("__setting_" .. qty .. "_tens").CurrentStage - 1) * 10
    local ones = (Tracker:FindObjectForCode("__setting_" .. qty .. "_ones").CurrentStage - 1)
    return Tracker:ProviderCountForCode("item__star") >= tens + ones
end

---@param code string Location code
---@return boolean
function HasCompleted(code)
    return Tracker:FindObjectForCode("__location_item_" .. code).Active
end

function ShowCoinStars()
    return Tracker:FindObjectForCode("__setting_100").Active
end

function ShowBuddies()
    return Tracker:FindObjectForCode("__setting_BB").Active
end

function ShowMushBlocks()
    return Tracker:FindObjectForCode("__setting_1UB").Active
end

---@param entrance string Entrance code
---@return boolean
function IsUnknownDestination(entrance)
    return Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == 0
end

---@param area string Location Region
---@param entrance string Entrance code
---@return boolean
function IsSelectedDestination(area, entrance)
    -- Special handling since there's multiple THI entrances.
    if area == "THI" then
    	return (
    	    Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage("THIh") or
            Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage("THIt")
    	)
    end

    return Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == EntranceTable:GetAreaStage(area)
end

-- TO BE REWRITTEN
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
