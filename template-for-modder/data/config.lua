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
["entering_pulsar"] = 1,
["entering_sun"] = 1,
["entering_storm"] = 1,
["entering_nebula"] = 1,
["fire_start"] = 1,
["low_oxygen"] = 1,
["asb_detected"] = 1,
["asb_willhit"] = 1,

--Boarding
["boarder_enemy"] = 1,
["boarder_friendly"] = 1,
["mc_enemy"] = 1,
["mc_friendly"] = 1,
["friendly_lowhp"] = 1,

--Weapon
["weapon_ready"] = 1,
["weapon_fire"] = 1,

--Drone
["space_drone_launch"] = 1,
["space_drone_destroyed"] = 1,

--System
["shield_damaged"] = 1,
["shield_ion"] = 1,
["shield_destroyed"] = 1,
["shield_hacked"] = 1,

["weapon_damaged"] = 1,
["weapon_ion"] = 1,
["weapon_destroyed"] = 1,
["weapon_hacked"] = 1,

["engine_damaged"] = 1,
["engine_ion"] = 1,
["engine_destroyed"] = 1,
["engine_hacked"] = 1,

["pilot_damaged"] = 1,
["pilot_ion"] = 1,
["pilot_destroyed"] = 1,
["pilot_hacked"] = 1,

["cloak_damaged"] = 1,
["cloak_ion"] = 1,
["cloak_destroyed"] = 1,
["cloak_hacked"] = 1,

["artilery_damaged"] = 1,
["artilery_ion"] = 1,
["artilery_destroyed"] = 1,
["artilery_hacked"] = 1,

["drone_damaged"] = 1,
["drone_ion"] = 1,
["drone_destroyed"] = 1,
["drone_hacked"] = 1,

["mind_damaged"] = 1,
["mind_ion"] = 1,
["mind_destroyed"] = 1,
["mind_hacked"] = 1,

["sensor_damaged"] = 1,
["sensor_ion"] = 1,
["sensor_destroyed"] = 1,
["sensor_hacked"] = 1,

["oxygen_damaged"] = 1,
["oxygen_ion"] = 1,
["oxygen_destroyed"] = 1,
["oxygen_hacked"] = 1,

["teleporter_damaged"] = 1,
["teleporter_ion"] = 1,
["teleporter_destroyed"] = 1,
["teleporter_hacked"] = 1,

["battery_damaged"] = 1,
["battery_ion"] = 1,
["battery_destroyed"] = 1,
["battery_hacked"] = 1,

["hacking_damaged"] = 1,
["hacking_ion"] = 1,
["hacking_destroyed"] = 1,
["hacking_hacked"] = 1,

["temporal_damaged"] = 1,
["temporal_ion"] = 1,
["temporal_destroyed"] = 1,
["temporal_hacked"] = 1,

--Ship Status
["hull_alert_75"] = 1,
["hull_alert_50"] = 1,
["hull_alert_25"] = 1,

--Action
["jumping_nocombat"] = 1,
["jumping_combat"] = 1,
["pause_true"] = 1,
["pause_false"] = 1,
]]

-- If you plan on only replacing the placeholder sounds, you can do it by heading to your audio/waves/va and placing your own sounds file with the same name (don't forget the _1, _2, _3, etc. at the end of the file name, if they are part of a list of sounds), 
-- they will get replaced automatically when the player load your mod AFTER the library


-- If you wish for a sound event to play from a list of sounds, you can update the number that way:
--[[
vas:addSound(hull_alert_75, 2)
]]
-- hull_alert_75 will now play a random sound from a list of 2 sounds

-- you can also override the default cooldown between each sound in the queue for this specific sound event:
--[[
vas:addSound(hull_alert_75, 2, 8)
]]
-- hull_alert_75 will now play a random sound from a list of 2 sounds, and the following sound in the list will have to wait 8 seconds before playing


-- You can also use the same method to add your own sound event:
--[[
vas:addSound(my_custom_event, 3)
]]

-- You can also remove a sound event from the list (if you do not like it, or have nothing to replace it with):
--[[
vas:removeSound(my_custom_event)
]]


-- You will have to setup your own callback to trigger the sound events, for example:
--[[
local function activate_power(power, ship)
    vas:playSound("my_custom_event")
end

script.on_internal_event(Defines.InternalEvents.ACTIVATE_POWER, activate_power)
]]
-- This will trigger the sound event "my_custom_event" when a crew power is activated
-- You will also need to add the sounds event to the list of sounds in the file sounds.xml.append
