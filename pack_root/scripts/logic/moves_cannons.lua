local move_code_lookup = {
    ["TJ"] = "item__cm_tj",
    ["LJ"] = "item__cm_lj",
    ["BF"] = "item__cm_bf",
    ["SF"] = "item__cm_sf",
    ["WK"] = "item__cm_wk",
    ["DV"] = "item__cm_dv",
    ["GP"] = "item__cm_gp",
    ["KK"] = "item__cm_kk",
    ["CL"] = "item__cm_cl",
    ["LG"] = "item__cm_lg",
}

local cap_code_lookup = {
    ["WC"] = "item__cm_wc",
    ["MC"] = "item__cm_mc",
    ["VC"] = "item__cm_vc",
}

local cannon_code_lookup = {
    ["BOB"] = "item__cann_bob",
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

---@param moves string A list of moves separated by `/` characters.
---@return boolean Returns true if any of the moves are accessible.
function HasMoves(moves)
    -- We always have the moves if moves are not randomized.
    if not Tracker:FindObjectForCode("__setting_MV").Active then
    	return true
    end

    for move in moves:gmatch("([^/]+)/?") do
    	local item = Tracker:FindObjectForCode(move_code_lookup[move])
    	if item ~= nil and item.Active then
    		return true
    	end
    end

    return false
end

---@param moves string A list of moves separated by `/` characters.
---@return boolean Returns true if all of the moves are accessible.
function HasAllMoves(moves)
    -- We always have the moves if moves are not randomized.
    if not Tracker:FindObjectForCode("__setting_MV").Active then
    	return true
    end

    for move in moves:gmatch("([^/]+)/?") do
    	local item = Tracker:FindObjectForCode(move_code_lookup[move])
    	if item == nil or not item.Active then
    		return false
    	end
    end

    return true
end

---@param course string The course code to check if cannon is unlocked.
---@return boolean Returns true if cannon is accessible.
function HasCannon(course)
    -- Generally, we always have access to the cannon if buddies are not randomized.
    if not Tracker:FindObjectForCode("__setting_BB").Active then
    	return true
    end

    local item = Tracker:FindObjectForCode(cannon_code_lookup[course])
    if item ~= nil and item.Active then
    	return true
    end

    return false
end

function HasCap(cap)
    local item = Tracker:FindObjectForCode(cap_code_lookup[cap])
    if item ~= nil and item.Active then
        return true
    end

    return false
end

function StrictCapAccessibilityLevel()
    if Tracker:FindObjectForCode("__setting_SC").CurrentStage == 1 then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function StrictCannonAccessibilityLevel()
    if Tracker:FindObjectForCode("__setting_SN").CurrentStage == 1 then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function StrictMovementAccessibilityLevel()
    if Tracker:FindObjectForCode("__setting_SM").CurrentStage == 1 then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end
