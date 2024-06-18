function CanAccessHMC()
    --- @type integer
    local accessibility_level = AccessibilityLevel.None
    for entrance, _ in pairs(EntranceTable["accessible"]) do
        local hmc_code = 6
        if Tracker:FindObjectForCode("__er_" .. entrance .. "_dst").CurrentStage == hmc_code then
        	local level = Tracker:FindObjectForCode("@" .. EntranceTable["code_lookup"][entrance] .. " Entrance").AccessibilityLevel
        	if level > accessibility_level then
        		accessibility_level = level
        	end
        end
    end

    return accessibility_level
end

function CanAccessBasement()
    if Tracker:FindObjectForCode("key").CurrentStage & 1 == 1 then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function CanAccessUpstairs()
    if Tracker:FindObjectForCode("key").CurrentStage & 2 == 2 then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function HasCompleted(code)
    if Tracker:FindObjectForCode(code).Active then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function HasCannon(stage)
    if not Tracker:FindObjectForCode("__setting_BB").Active then
    	return AccessibilityLevel.Normal
    end

    if Tracker:FindObjectForCode("cannon_" .. stage).Active then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function HasCap(cap)
    if Tracker:FindObjectForCode("cap_" .. cap).Active then
    	return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function IsCapless()
    if Tracker:FindObjectForCode("__setting_SC").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function IsCannonless()
    if Tracker:FindObjectForCode("__setting_SN").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function IsMoveless()
    if Tracker:FindObjectForCode("__setting_SM").CurrentStage == 1 then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function IncludeHundredCoins()
    return Tracker:FindObjectForCode("__setting_100").Active
end

function IncludeOneUpBlocks()
    return Tracker:FindObjectForCode("__setting_1UB").Active
end

function IncludeBuddies()
    return Tracker:FindObjectForCode("__setting_BB").Active
end

function CanAccessJRBShip()
    if HasMove("triple_jump") or HasMove("backflip") or HasMove("side_flip") or HasMove("wall_jump") then
    	return AccessibilityLevel.Normal
    elseif HasMove("ledge_grab") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessBBHThirdFloor()
    if HasMove("triple_jump") and HasMove("wall_jump") then
    	return AccessibilityLevel.Normal
    elseif HasMove("wall_jump") then
    	return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessBBHRoof()
    local access_third = CanAccessBBHThirdFloor()
    if access_third == 0 then
    	return AccessibilityLevel.None
    elseif HasMove("long_jump") then
        return access_third
    elseif IsMoveless() then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessHMCRedCoinsArea()
    if HasMove("climb") and (HasMove("wall_jump") or HasMove("ledge_grab") or HasMove("backflip") or HasMove("side_flip") or HasMove("triple_jump")) then
    	return AccessibilityLevel.Normal
    elseif HasMove("wall_jump") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessHMCPitIslands()
    if HasMove("triple_jump") and HasMove("climb") then
    	return AccessibilityLevel.Normal
    elseif HasMove("wall_jump") and (HasMove("triple_jump") or HasMove("long_jump")) then
        return IsMoveless()
    elseif HasMove("wall_jump") and HasMove("side_flip") and HasMove("ledge_grab") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessSSLUpperPyramid()
    if HasMove("climb") and (HasMove("triple_jump") or HasMove("backflip") or HasMove("side_flip") or HasMove("ledge_grab")) then
    	return AccessibilityLevel.Normal
    elseif IsMoveless() then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessWDWTop()
    if HasMove("wall_jump") or HasMove("triple_jump") or HasMove("side_flip") or HasMove("backflip") then
    	return AccessibilityLevel.Normal
    elseif IsMoveless() then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function IsEREnabled()
    return Tracker:FindObjectForCode("__setting_ER").CurrentStage > 0
end

function IsERDisabled()
    return not IsEREnabled()
end

function CanAccessWDWDowntown()
    if IsERDisabled() and HasMove("ledge_grab") and (HasMove("triple_jump") or HasMove("side_flip") or HasMove("backflip")) then
    	return AccessibilityLevel.Normal
    elseif HasCannon("wdw") then
        return AccessibilityLevel.Normal
    elseif HasMove("triple_jump") and HasMove("dive") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTTMTop()
    if (HasMove("long_jump") or HasMove("dive")) and (HasMove("ledge_grab") or HasMove("kick")) then
    	return AccessibilityLevel.Normal
    elseif HasMove("triple_jump") then
        return IsMoveless()
    elseif HasMove("wall_jump") and (HasMove("side_flip") or HasMove("ledge_grab")) then
        return IsMoveless()
    elseif HasMove("kick") or HasMove("dive") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTHIPipes()
    if IsERDisabled() then
    	return AccessibilityLevel.Normal
    elseif HasMove("long_jump") or HasMove("triple_jump") or HasMove("dive") or HasMove("ledge_grab") then
        return AccessibilityLevel.Normal
    elseif HasMove("backflip") or HasMove("side_flip") or HasMove("kick") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTHIHugeTop()
    if CanAccessTHIPipes() == 0 then
    	return AccessibilityLevel.None
    end

    if IsERDisabled() then
    	return AccessibilityLevel.Normal
    elseif HasMove("long_jump") or HasMove("triple_jump") or HasMove("dive") then
        return AccessibilityLevel.Normal
    elseif IsMoveless() then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTTCLower()
    if HasMove("ledge_grab") or HasMove("triple_jump") or HasMove("side_flip") or HasMove("backflip") or HasMove("wall_jump") then
    	return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTTCUpper()
    if CanAccessTTCLower() == 0 then
    	return AccessibilityLevel.None
    end

    if HasMove("climb") then
    	return AccessibilityLevel.Normal
    elseif HasMove("wall_jump") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end

function CanAccessTTCTop()
    local can_access_ttc_upper = CanAccessTTCUpper()
    if can_access_ttc_upper == 0 then
    	return AccessibilityLevel.None
    end

    if HasMove("triple_jump") and HasMove("ledge_grab") then
    	return can_access_ttc_upper
    elseif HasMove("wall_jump") or HasMove("triple_jump") then
        return IsMoveless()
    else
        return AccessibilityLevel.None
    end
end
