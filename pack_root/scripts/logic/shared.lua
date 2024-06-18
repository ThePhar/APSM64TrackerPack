---@param rules table
---@return integer
function GetAccessibility(rules)
    local accessibility_level = AccessibilityLevel.None
    for _, result in ipairs(rules) do
    	if tonumber(result) ~= nil then
    		accessibility_level = math.max(accessibility_level, result)
        elseif result then
            return AccessibilityLevel.Normal
    	end
    end

    return accessibility_level
end

function HasStars(target)
    local count = tonumber(target) or Tracker:ProviderCountForCode("__setting_" .. target)
    return Tracker:ProviderCountForCode("item__star") >= count
end

function HasCompleted(code)
    return Tracker:FindObjectForCode("__location_item_" .. code).Active
end

function IsNoAreaRando()
    return Tracker:FindObjectForCode("__setting_ER").CurrentStage == 0
end

function CanAccessBasement()
    return Tracker:FindObjectForCode("item__key").CurrentStage & 1 == 1
end

function CanAccessDDD()
    return CanAccessBasement() and HasStars("B1Door")
end

function CanAccessSecondFloor()
    return Tracker:FindObjectForCode("item__key").CurrentStage & 2 == 2
end

function CanAccessThirdFloor()
    return CanAccessSecondFloor() and HasStars("F2Door")
end

function CanAccessSA()
    return GetAccessibility({
        (HasMoves("SF/BF")),
        (HasAllMoves("TJ/LG")),
        (HasMoves("TJ") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessHMC()
    --- @type integer
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

function ShowCoinStars()
    return Tracker:FindObjectForCode("__setting_100").Active
end

function ShowBuddies()
    return Tracker:FindObjectForCode("__setting_BB").Active
end

function ShowBlocks()
    return Tracker:FindObjectForCode("__setting_1UB").Active
end
