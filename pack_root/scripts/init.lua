ENABLE_DEBUG_LOG = true

print("\n-- Loading Phar's SM64 Tracker --")
print("Variant: ", Tracker.ActiveVariantUID)
if ENABLE_DEBUG_LOG then
	print("Debug Logging Enabled")
	ScriptHost:LoadScript("scripts/utils.lua")
end

-- Map
Tracker:AddMaps("maps/maps.json")

-- Items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/options.json")
Tracker:AddItems("items/area_rando.json")
Tracker:AddItems("items/locations.json")

-- Locations
Tracker:AddLocations("locations/locations.json")
Tracker:AddLocations("locations/castle_entrances.json")

-- Layout
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- Utility Script for helper functions etc.
--ScriptHost:LoadScript("scripts/logic.lua")
ScriptHost:LoadScript("scripts/er.lua")
ScriptHost:LoadScript("scripts/logic/shared.lua")
ScriptHost:LoadScript("scripts/logic/moves_cannons.lua")
ScriptHost:LoadScript("scripts/logic/stage_bob.lua")


-- AutoTracking
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
