ENABLE_DEBUG_LOG = true

print("\n-- Loading Phar's SM64 Tracker --")
print("Variant: ", Tracker.ActiveVariantUID)
if ENABLE_DEBUG_LOG then
	ScriptHost:LoadScript("scripts/utils.lua")
	print("Debug Logging Enabled")
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

-- Layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- Scripts
ScriptHost:LoadScript("scripts/logic/area_rando.lua")
ScriptHost:LoadScript("scripts/logic/shared.lua")
ScriptHost:LoadScript("scripts/logic/moves_cannons.lua")

ScriptHost:LoadScript("scripts/logic/stages/bob.lua")
ScriptHost:LoadScript("scripts/logic/stages/wf.lua")
ScriptHost:LoadScript("scripts/logic/stages/jrb.lua")
ScriptHost:LoadScript("scripts/logic/stages/ccm.lua")
ScriptHost:LoadScript("scripts/logic/stages/bbh.lua")
ScriptHost:LoadScript("scripts/logic/stages/hmc.lua")
ScriptHost:LoadScript("scripts/logic/stages/ssl.lua")
ScriptHost:LoadScript("scripts/logic/stages/ddd.lua")
ScriptHost:LoadScript("scripts/logic/stages/sl.lua")
ScriptHost:LoadScript("scripts/logic/stages/wdw.lua")
ScriptHost:LoadScript("scripts/logic/stages/ttm.lua")
ScriptHost:LoadScript("scripts/logic/stages/thi.lua")

-- AutoTracking
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
