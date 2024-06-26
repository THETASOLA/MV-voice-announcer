if not mods.vasystem then return end
local vas = mods.vasystem

--Config:

-- Define the max number of sounds that can be queued, if the queue is full, the sound will not be added to the queue
vas.sound_queue_max = 5

-- Define the default cooldown between each sound in the queue to prevent overlapping (Hyperspace cannot calculate the duration of a sound), can be overriden by specific sound event
vas.sound_queue_set_cd = 2

-- This is the list of the currently supported sound events with their list, all having "1" sound in it currently
--[[
--Hazard
["va_entering_pulsar"] = 1,
["va_entering_sun"] = 1,
["va_entering_storm"] = 1,
["va_entering_nebula"] = 1,
["va_fire_start"] = 1,
["va_low_oxygen"] = 1,
["va_asb_detected"] = 1,
["va_asb_willhit"] = 1,

--Boarding
["va_boarder_enemy"] = 1,
["va_boarder_friendly"] = 1,
["va_mc_enemy"] = 1,
["va_mc_friendly"] = 1,
["va_friendly_lowhp"] = 1,

--Weapon
["va_weapon_ready"] = 1,
["va_weapon_fire"] = 1,

--Drone
["va_space_drone_launch"] = 1,
["va_space_drone_destroyed"] = 1,

--System
["va_shield_damaged"] = 1,
["va_shield_ion"] = 1,
["va_shield_destroyed"] = 1,
["va_shield_hacked"] = 1,

["va_weapon_damaged"] = 1,
["va_weapon_ion"] = 1,
["va_weapon_destroyed"] = 1,
["va_weapon_hacked"] = 1,

["va_engine_damaged"] = 1,
["va_engine_ion"] = 1,
["va_engine_destroyed"] = 1,
["va_engine_hacked"] = 1,

["va_pilot_damaged"] = 1,
["va_pilot_ion"] = 1,
["va_pilot_destroyed"] = 1,
["va_pilot_hacked"] = 1,

["va_cloak_damaged"] = 1,
["va_cloak_ion"] = 1,
["va_cloak_destroyed"] = 1,
["va_cloak_hacked"] = 1,

["va_artillery_damaged"] = 1,
["va_artillery_ion"] = 1,
["va_artillery_destroyed"] = 1,
["va_artillery_hacked"] = 1,

["va_drone_damaged"] = 1,
["va_drone_ion"] = 1,
["va_drone_destroyed"] = 1,
["va_drone_hacked"] = 1,

["va_mind_damaged"] = 1,
["va_mind_ion"] = 1,
["va_mind_destroyed"] = 1,
["va_mind_hacked"] = 1,

["va_sensor_damaged"] = 1,
["va_sensor_ion"] = 1,
["va_sensor_destroyed"] = 1,
["va_sensor_hacked"] = 1,

["va_oxygen_damaged"] = 1,
["va_oxygen_ion"] = 1,
["va_oxygen_destroyed"] = 1,
["va_oxygen_hacked"] = 1,

["va_teleporter_damaged"] = 1,
["va_teleporter_ion"] = 1,
["va_teleporter_destroyed"] = 1,
["va_teleporter_hacked"] = 1,

["va_battery_damaged"] = 1,
["va_battery_ion"] = 1,
["va_battery_destroyed"] = 1,
["va_battery_hacked"] = 1,

["va_door_damaged"] = 1,
["va_door_ion"] = 1,
["va_door_destroyed"] = 1,
["va_door_hacked"] = 1,

["va_medbay_damaged"] = 1,
["va_medbay_ion"] = 1,
["va_medbay_destroyed"] = 1,
["va_medbay_hacked"] = 1,

["va_clonebay_damaged"] = 1,
["va_clonebay_ion"] = 1,
["va_clonebay_destroyed"] = 1,
["va_clonebay_hacked"] = 1,

["va_hacking_damaged"] = 1,
["va_hacking_ion"] = 1,
["va_hacking_destroyed"] = 1,
["va_hacking_hacked"] = 1,

["va_temporal_damaged"] = 1,
["va_temporal_ion"] = 1,
["va_temporal_destroyed"] = 1,
["va_temporal_hacked"] = 1,

--Ship Status
["va_hull_alert_75"] = 1,
["va_hull_alert_50"] = 1,
["va_hull_alert_25"] = 1,

--Action
["va_jumping_nocombat"] = 1,
["va_jumping_combat"] = 1,
["va_pause_true"] = 1,
["va_pause_false"] = 1,
]]

-- To replace the placeholder sounds, place your own sound files in the "audio/waves/va" folder.
-- Ensure your files have the same names (including the suffix _1, _2, _3, etc., for lists of sounds).
-- These will automatically replace the placeholders when the player loads your mod after the library.

-- To have a sound event play from a list of sounds, update the number as shown below:
--[[ 
vas:addSound(string sound_event, int number_of_sounds, int cooldown (optional))

vas:addSound("va_hull_alert_75", 2)
-- This makes "va_hull_alert_75" play a random sound from a list of 2 sounds.
]]

-- To override the default cooldown between sounds for a specific event:
--[[
vas:addSound("va_hull_alert_75", 2, 8)
-- This makes "va_hull_alert_75" play a random sound from a list of 2 sounds, with an 8-second cooldown before the next sound plays.
]]

-- To add your own custom sound event:
--[[
vas:addSound("va_my_custom_event", 3)
]]

-- To remove a sound event from the list:
--[[
vas:removeSound("va_my_custom_event")
]]

-- To add a special sound to an event with a specific probability and optional cooldown (only one per event):
-- Can be used to either set a high probability sound amidst a list of special one, or a unique sound with a low probability.
--[[ 
vas:addSpecialSound(string sound_event, float probability, int cooldown (optional))

vas:addSpecialSound("va_my_custom_event", 0.5)
-- or
vas:addSpecialSound("va_my_custom_event", 0.5, 5)
]]

-- Set up your own callback to trigger the sound events, for example:
--[[
local function activate_power(power, ship)
    vas:playSound("va_my_custom_event")
end

script.on_internal_event(Defines.InternalEvents.ACTIVATE_POWER, activate_power)

-- This triggers the sound event "va_my_custom_event" when a crew power is activated.
-- Also, add the sound event to the list in the sounds.xml.append file.
]]

