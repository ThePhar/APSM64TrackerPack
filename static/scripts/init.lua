ENABLE_DEBUG_LOG = false

print("\n-- Loading Phar's SM64 Tracker --")
print("Variant: ", Tracker.ActiveVariantUID)
if ENABLE_DEBUG_LOG then
	ScriptHost:LoadScript("scripts/debug.lua")
	print("Debug Logging Enabled")
end

if Tracker.AllowDeferredLogicUpdate ~= nil then
	Tracker.AllowDeferredLogicUpdate = true
end

-- Maps
Tracker:AddMaps("maps/maps.json")

-- Items
Tracker:AddItems("items/area_rando.json")
Tracker:AddItems("items/core.json")
Tracker:AddItems("items/locations.json")
Tracker:AddItems("items/options.json")

-- Locations
Tracker:AddLocations("locations/castle_locations.json")
Tracker:AddLocations("locations/castle_entrances.json")

-- Layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/locations.json")
Tracker:AddLayouts("layouts/entrances.json")
Tracker:AddLayouts("layouts/logic.json")
Tracker:AddLayouts("layouts/requirements.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/tracker.json")

-- Scripts
ScriptHost:LoadScript("scripts/locations.lua")
ScriptHost:LoadScript("scripts/logic.lua")
ScriptHost:LoadScript("scripts/requirements.lua")
ScriptHost:LoadScript("scripts/areas.lua")

-- AutoTracking via Archipelago
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
