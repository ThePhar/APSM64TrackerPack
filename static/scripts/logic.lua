---@param type string
---@return number
function StrictAccessibility(type)
    if type == "MOVELESS" then
        if Tracker:FindObjectForCode("__setting_SM").CurrentStage == 1 then
            return AccessibilityLevel.Normal
        end

        return AccessibilityLevel.SequenceBreak
    elseif type == "CAPLESS" then
        if Tracker:FindObjectForCode("__setting_SC").CurrentStage == 1 then
            return AccessibilityLevel.Normal
        end

        return AccessibilityLevel.SequenceBreak
    elseif type == "CANNLESS" then
        if Tracker:FindObjectForCode("__setting_SN").CurrentStage == 1 then
            return AccessibilityLevel.Normal
        end

        return AccessibilityLevel.SequenceBreak
    end

    -- This doesn't seem right?
    return AccessibilityLevel.None
end

---@param items string A string of moves/caps, delimited by `/` characters.
---@return boolean Returns true if any given item is acquired.
function Has(items)
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

    local cap_code_lookup = {
        ["WC"] = "item__cm_wc", -- Wing Cap
        ["MC"] = "item__cm_mc", -- Metal Cap
        ["VC"] = "item__cm_vc", -- Vanish Cap
    }

    local move_rando = Tracker:FindObjectForCode("__setting_MV").Active
    for item in items:gmatch("([^/]+)/?") do
        if move_code_lookup[item] ~= nil then
            if not move_rando then
                return true
            elseif Tracker:FindObjectForCode(move_code_lookup[item]).Active then
                return true
            end
        else
            if Tracker:FindObjectForCode(cap_code_lookup[item]).Active then
                return true
            end
        end
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

---@return boolean
function NoAreaRando()
    for stage, _ in pairs(EntranceTable["name"]) do
        local stage_idx = Tracker:FindObjectForCode("__er_" .. stage .. "_dst").CurrentStage
        if EntranceTable["stage"][stage_idx] ~= stage then
            return false
        end
    end

    return true
end

---@return boolean
function AreaRando()
    return not NoAreaRando()
end

---@param area string The area that could be accessible.
---@return boolean Returns true if player can access this area.
function CanAccess(area)
    local accessibility_level = AccessibilityLevel.None
    if area == "HMC" then
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
    elseif area == "B1" then
        return Tracker:FindObjectForCode("item__key").CurrentStage & 1 == 1
    elseif area == "F2" then
        return Tracker:FindObjectForCode("item__key").CurrentStage & 2 == 2
    elseif area == "F3" then
        return Tracker:FindObjectForCode("item__key").CurrentStage & 2 == 2 and HasStars("F2")
    end

    return accessibility_level
end

---@return boolean Returns true if player has completed sub.
function Sub()
    return Tracker:FindObjectForCode("__location_item_3626056").Active
end

---@return boolean Returns true if all bowsers are required.
function AllBowsers()
    if Tracker:FindObjectForCode("__setting_GOAL").CurrentStage == 1 then
        return true
    else
        return false
    end
end

---@return boolean Returns true if player has completed Bowser 2.
function BeatBowser2()
    return Tracker:FindObjectForCode("__location_item_3626179").Active
end

function ShowCoinStars()
    return Tracker:FindObjectForCode("__setting_100").Active
end

function ShowBuddies()
    -- return Tracker:FindObjectForCode("__setting_BB").Active
    return true
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
