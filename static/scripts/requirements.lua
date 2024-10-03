local maximum_qty = {
    ["F1"] = 48,
    ["B1"] = 60,
    ["F2"] = 84,
    ["F3"] = 108,
    ["MIPS1"] = 42,
    ["MIPS2"] = 84,
}

---@param code string
function increment(code)
    -- Extract code
    local _, i = code:find("__setting_")
    code = code:sub(i + 1)
    code = code:sub(1, -6)

    local tens = (Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage - 1) * 10
    local ones = (Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage - 1)
    if ones == 10 then
        tens = tens + 10
        ones = 0

        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_tens")
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_ones")
        Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage = (tens + 10) / 10
        Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage = ones + 1
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_tens", "__setting_" .. code .. "_tens", increment)
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_ones", "__setting_" .. code .. "_ones", increment)
    end

    if ones == -1 then
        tens = tens - 10
        ones = 9
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_tens")
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_ones")
        Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage = (tens + 10) / 10
        Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage = ones + 1
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_tens", "__setting_" .. code .. "_tens", increment)
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_ones", "__setting_" .. code .. "_ones", increment)
    end

    if tens == -10 then
        tens = 0
        ones = 0
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_tens")
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_ones")
        Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage = (tens + 10) / 10
        Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage = ones + 1
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_tens", "__setting_" .. code .. "_tens", increment)
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_ones", "__setting_" .. code .. "_ones", increment)
    end

    local count = tens + ones
    if count > maximum_qty[code] then
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_tens")
        ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_ones")
        Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage = (GetDigit(maximum_qty[code], 2) + 1) + (GetDigit(maximum_qty[code], 3) * 10)
        Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage = GetDigit(maximum_qty[code], 1) + 1
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_tens", "__setting_" .. code .. "_tens", increment)
        ScriptHost:AddWatchForCode("__setting_" .. code .. "_ones", "__setting_" .. code .. "_ones", increment)
    end
end

function SetStarReq(code, qty)
    ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_tens")
    ScriptHost:RemoveWatchForCode("__setting_" .. code .. "_ones")
    Tracker:FindObjectForCode("__setting_" .. code .. "_tens").CurrentStage = (GetDigit(qty, 2) + 1) + (GetDigit(qty, 3) * 10)
    Tracker:FindObjectForCode("__setting_" .. code .. "_ones").CurrentStage = GetDigit(qty, 1) + 1
    ScriptHost:AddWatchForCode("__setting_" .. code .. "_tens", "__setting_" .. code .. "_tens", increment)
    ScriptHost:AddWatchForCode("__setting_" .. code .. "_ones", "__setting_" .. code .. "_ones", increment)
end

ScriptHost:AddWatchForCode("__setting_F1_tens", "__setting_F1_tens", increment)
ScriptHost:AddWatchForCode("__setting_B1_tens", "__setting_B1_tens", increment)
ScriptHost:AddWatchForCode("__setting_F2_tens", "__setting_F2_tens", increment)
ScriptHost:AddWatchForCode("__setting_F3_tens", "__setting_F3_tens", increment)
ScriptHost:AddWatchForCode("__setting_MIPS1_tens", "__setting_MIPS1_tens", increment)
ScriptHost:AddWatchForCode("__setting_MIPS2_tens", "__setting_MIPS2_tens", increment)
ScriptHost:AddWatchForCode("__setting_F1_ones", "__setting_F1_ones", increment)
ScriptHost:AddWatchForCode("__setting_B1_ones", "__setting_B1_ones", increment)
ScriptHost:AddWatchForCode("__setting_F2_ones", "__setting_F2_ones", increment)
ScriptHost:AddWatchForCode("__setting_F3_ones", "__setting_F3_ones", increment)
ScriptHost:AddWatchForCode("__setting_MIPS1_ones", "__setting_MIPS1_ones", increment)
ScriptHost:AddWatchForCode("__setting_MIPS2_ones", "__setting_MIPS2_ones", increment)

function GetDigit(num, digit)
    local n = 10 ^ digit
    local n1 = 10 ^ (digit - 1)
    return math.floor((num % n) / n1)
end

ScriptHost:AddWatchForCode("Toggle Spoil Reqs", "__setting_spoil_reqs", function()
    if SLOT_DATA == nil then
        return
    end

    if Tracker:FindObjectForCode("__setting_spoil_reqs").CurrentStage == 1 then
        SetStarReq("F1", SLOT_DATA["FirstBowserDoorCost"])
        SetStarReq("B1", SLOT_DATA["BasementDoorCost"])
        SetStarReq("F2", SLOT_DATA["SecondFloorDoorCost"])
        SetStarReq("F3", SLOT_DATA["StarsToFinish"])
        SetStarReq("MIPS1", SLOT_DATA["MIPS1Cost"])
        SetStarReq("MIPS2", SLOT_DATA["MIPS2Cost"])
    end
end)
