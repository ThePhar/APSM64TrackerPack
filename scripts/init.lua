ENABLE_DEBUG_LOG = true

print("-- Loading Phar's SM64 Tracker --")
print("-- Variant: ", Tracker.ActiveVariantUID)
if ENABLE_DEBUG_LOG then
	print("Debug logging is enabled!")
end

-- Map
Tracker:AddMaps("maps/maps.json")

-- Items
Tracker:AddItems("items/real_items.json")
Tracker:AddItems("items/er_items.json")
Tracker:AddItems("items/settings_items.json")
Tracker:AddItems("items/location_items.json")

-- Locations
Tracker:AddLocations("locations/locations.json")
Tracker:AddLocations("locations/entrances.json")

-- Layout
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/logic.lua")
ScriptHost:LoadScript("scripts/er.lua")

-- AutoTracking
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
