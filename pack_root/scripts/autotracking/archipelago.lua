ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/er_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
        print(dump_table(slot_data))
    end
    SLOT_DATA = slot_data

    CUR_INDEX = -1
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}

    -- Reset key
    Tracker:FindObjectForCode("item__key").CurrentStage = 0

    -- Set Slot Data
    --- @type JsonItem
    Tracker:FindObjectForCode("__setting_F1Door").AcquiredCount = SLOT_DATA["FirstBowserDoorCost"]
    Tracker:FindObjectForCode("__setting_B1Door").AcquiredCount = SLOT_DATA["BasementDoorCost"]
    Tracker:FindObjectForCode("__setting_F2Door").AcquiredCount = SLOT_DATA["SecondFloorDoorCost"]
    Tracker:FindObjectForCode("__setting_F3Door").AcquiredCount = SLOT_DATA["StarsToFinish"]
    Tracker:FindObjectForCode("__setting_MIPS1").AcquiredCount = SLOT_DATA["MIPS1Cost"]
    Tracker:FindObjectForCode("__setting_MIPS2").AcquiredCount = SLOT_DATA["MIPS2Cost"]
    Tracker:FindObjectForCode("__setting_GOAL").CurrentStage = SLOT_DATA["CompletionType"]
    Tracker:FindObjectForCode("__setting_MV").Active = SLOT_DATA["MoveRandoVec"] ~= 0

    -- Set Moves to Enabled if in Move Rando and they're not shuffled. Not that it does anything, but i think its nice.
    Tracker:FindObjectForCode("item__cm_tj").Active = SLOT_DATA["MoveRandoVec"] & 2    ~= 2
    Tracker:FindObjectForCode("item__cm_lj").Active = SLOT_DATA["MoveRandoVec"] & 4    ~= 4
    Tracker:FindObjectForCode("item__cm_bf").Active = SLOT_DATA["MoveRandoVec"] & 8    ~= 8
    Tracker:FindObjectForCode("item__cm_sf").Active = SLOT_DATA["MoveRandoVec"] & 16   ~= 16
    Tracker:FindObjectForCode("item__cm_wk").Active = SLOT_DATA["MoveRandoVec"] & 32   ~= 32
    Tracker:FindObjectForCode("item__cm_dv").Active = SLOT_DATA["MoveRandoVec"] & 64   ~= 64
    Tracker:FindObjectForCode("item__cm_gp").Active = SLOT_DATA["MoveRandoVec"] & 128  ~= 128
    Tracker:FindObjectForCode("item__cm_kk").Active = SLOT_DATA["MoveRandoVec"] & 256  ~= 256
    Tracker:FindObjectForCode("item__cm_cl").Active = SLOT_DATA["MoveRandoVec"] & 512  ~= 512
    Tracker:FindObjectForCode("item__cm_lg").Active = SLOT_DATA["MoveRandoVec"] & 1024 ~= 1024

    -- Enable ER if we notice entrances different, but not spoiling them! ;)
    for i, _ in pairs(COURSE_MAPPING) do
    	if SLOT_DATA["AreaRando"][tostring(i)] ~= i then
    		Tracker:FindObjectForCode("__setting_ER").CurrentStage = 1
    		break
    	end
    end
    if Tracker:FindObjectForCode("__setting_ER").CurrentStage > 0 then
        for i, _ in pairs(SECRET_MAPPING) do
            if SLOT_DATA["AreaRando"][tostring(i)] ~= i then
                Tracker:FindObjectForCode("__setting_ER").CurrentStage = 2
                break
            end
        end
    end
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
        return
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        -- Progressive Key Handling
        if v[1] == "key" and v[2] == 0 then
            obj.CurrentStage = (obj.CurrentStage << 1) | 1
        elseif v[1] == "key" then
            obj.CurrentStage = obj.CurrentStage | v[2]
        elseif v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end
