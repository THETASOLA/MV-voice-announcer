mods.vasystem = {}
local vas = mods.vasystem

vas.sound_queue = {}
vas.sound_queue_max = 5
vas.sound_queue_set_cd = 2 --To avoid overlapping
vas.sound_queue_cd = 0
vas.hookSounds = {}
vas.specialHookSounds = {}

-- Add a sound to the event list
function vas:addSound(sound, num, time)
    vas.hookSounds[sound] = {
        lSize = num,
        Time = time or vas.sound_queue_set_cd
    }
end

-- Add a special sound to the event list, can only be one per event, probability is the chance of the sound to be played when encountering the event (ex: 0.5 = 50%)
function vas:addSpecialSound(sound, probability, time)
    vas.specialHookSounds[sound] = {
        Time = time or vas.sound_queue_set_cd,
        probability = probability
    }
end

vas:addSound("va_entering_pulsar", 1)
vas:addSound("va_entering_sun", 1)
vas:addSound("va_entering_storm", 1)
vas:addSound("va_entering_nebula", 1)
vas:addSound("va_fire_start", 1)
vas:addSound("va_low_oxygen", 1)
vas:addSound("va_asb_detected", 1)
vas:addSound("va_asb_willhit", 1)

vas:addSound("va_boarder_enemy", 1)
vas:addSound("va_boarder_friendly", 1)
vas:addSound("va_mc_enemy", 1)
vas:addSound("va_mc_friendly", 1)
vas:addSound("va_friendly_lowhp", 1)

vas:addSound("va_weapon_ready", 1)
vas:addSound("va_weapon_fire", 1)

vas:addSound("va_space_drone_launch", 1)
vas:addSound("va_space_drone_destroyed", 1)

vas:addSound("va_shield_damaged", 1)
vas:addSound("va_shield_ion", 1)
vas:addSound("va_shield_destroyed", 1)
vas:addSound("va_shield_hacked", 1)

vas:addSound("va_weapon_damaged", 1)
vas:addSound("va_weapon_ion", 1)
vas:addSound("va_weapon_destroyed", 1)
vas:addSound("va_weapon_hacked", 1)

vas:addSound("va_engine_damaged", 1)
vas:addSound("va_engine_ion", 1)
vas:addSound("va_engine_destroyed", 1)
vas:addSound("va_engine_hacked", 1)

vas:addSound("va_pilot_damaged", 1)
vas:addSound("va_pilot_ion", 1)
vas:addSound("va_pilot_destroyed", 1)
vas:addSound("va_pilot_hacked", 1)

vas:addSound("va_cloak_damaged", 1)
vas:addSound("va_cloak_ion", 1)
vas:addSound("va_cloak_destroyed", 1)
vas:addSound("va_cloak_hacked", 1)

vas:addSound("va_drone_damaged", 1)
vas:addSound("va_drone_ion", 1)
vas:addSound("va_drone_destroyed", 1)
vas:addSound("va_drone_hacked", 1)

vas:addSound("va_mind_damaged", 1)
vas:addSound("va_mind_ion", 1)
vas:addSound("va_mind_destroyed", 1)
vas:addSound("va_mind_hacked", 1)

vas:addSound("va_sensor_damaged", 1)
vas:addSound("va_sensor_ion", 1)
vas:addSound("va_sensor_destroyed", 1)
vas:addSound("va_sensor_hacked", 1)

vas:addSound("va_oxygen_damaged", 1)
vas:addSound("va_oxygen_ion", 1)
vas:addSound("va_oxygen_destroyed", 1)
vas:addSound("va_oxygen_hacked", 1)

vas:addSound("va_door_damaged", 1)
vas:addSound("va_door_ion", 1)
vas:addSound("va_door_destroyed", 1)
vas:addSound("va_door_hacked", 1)

vas:addSound("va_medbay_damaged", 1)
vas:addSound("va_medbay_ion", 1)
vas:addSound("va_medbay_destroyed", 1)
vas:addSound("va_medbay_hacked", 1)

vas:addSound("va_clonebay_damaged", 1)
vas:addSound("va_clonebay_ion", 1)
vas:addSound("va_clonebay_destroyed", 1)
vas:addSound("va_clonebay_hacked", 1)

vas:addSound("va_artillery_damaged", 1)
vas:addSound("va_artillery_ion", 1)
vas:addSound("va_artillery_destroyed", 1)
vas:addSound("va_artillery_hacked", 1)

vas:addSound("va_teleporter_damaged", 1)
vas:addSound("va_teleporter_ion", 1)
vas:addSound("va_teleporter_destroyed", 1)
vas:addSound("va_teleporter_hacked", 1)

vas:addSound("va_battery_damaged", 1)
vas:addSound("va_battery_ion", 1)
vas:addSound("va_battery_destroyed", 1)
vas:addSound("va_battery_hacked", 1)

vas:addSound("va_hacking_damaged", 1)
vas:addSound("va_hacking_ion", 1)
vas:addSound("va_hacking_destroyed", 1)
vas:addSound("va_hacking_hacked", 1)

vas:addSound("va_temporal_damaged", 1)
vas:addSound("va_temporal_ion", 1)
vas:addSound("va_temporal_destroyed", 1)
vas:addSound("va_temporal_hacked", 1)

vas:addSound("va_hull_alert_75", 1)
vas:addSound("va_hull_alert_50", 1)
vas:addSound("va_hull_alert_25", 1)

vas:addSound("va_jumping_nocombat", 1)
vas:addSound("va_jumping_combat", 1)
vas:addSound("va_pause_true", 1)
vas:addSound("va_pause_false", 1)

function vas:removeSound(sound)
    for i, v in ipairs(vas.hookSounds) do
        if v == sound then
            table.remove(vas.hookSounds, i)
            return
        end
    end
end

function vas:playSound(sound)
    if not vas.hookSounds[sound] or not vas.specialHookSounds[sound] then return end
    if #vas.sound_queue >= vas.sound_queue_max then return end
    for _, v in ipairs(vas.sound_queue) do
        if v == sound then return end
    end

    table.insert(vas.sound_queue, sound)
end

function vas:playSoundQueue()
    local sound = table.remove(vas.sound_queue, 1)
    local num = math.random(1, vas.hookSounds[sound].lSize)
    local sound_path = sound..tostring(num)
    if vas.specialHookSounds[sound] and math.random() < vas.specialHookSounds[sound].probability then
        sound_path = sound.."special"
    end
    Hyperspace.Sounds:PlaySoundMix(sound_path, -1, false)
    vas.sound_queue_cd = vas.hookSounds[sound].Time
end

function vas:clearQueue()
    vas.sound_queue = {}
end

function vas:removeSoundQueue(sound)
    for i, v in ipairs(vas.sound_queue) do
        if v == sound then
            table.remove(vas.sound_queue, i)
            return
        end
    end
end

script.on_internal_event(Defines.InternalEvents.ON_TICK, function()
    vas.sound_queue_cd = math.max(vas.sound_queue_cd - Hyperspace.FPS.SpeedFactor/16, 0)
    if #vas.sound_queue == 0 or vas.sound_queue_cd ~= 0 then return end

    vas:playSoundQueue()
end)

function mods.v(sound) -- this is for debug
    Hyperspace.Sounds:PlaySoundMix(sound, -1, false)
end