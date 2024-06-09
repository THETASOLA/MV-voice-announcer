mods.vasystem = {}
local vas = mods.vasystem

vas.sound_queue = {}
vas.sound_queue_max = 5
vas.sound_queue_set_cd = 2 --I don't want the voiceline to overlap
vas.sound_queue_cd = 0
vas.hookSounds = {}

function vas:addSound(sound, num, time)
    vas.hookSounds[sound] = {
        lSize = num,
        Time = time or vas.sound_queue_set_cd
    }
end

vas:addSound("entering_pulsar", 1)
vas:addSound("entering_sun", 1)
vas:addSound("entering_storm", 1)
vas:addSound("entering_nebula", 1)
vas:addSound("fire_start", 1)
vas:addSound("low_oxygen", 1)
vas:addSound("asb_detected", 1)
vas:addSound("asb_willhit", 1)

vas:addSound("boarder_enemy", 1)
vas:addSound("boarder_friendly", 1)
vas:addSound("mc_enemy", 1)
vas:addSound("mc_friendly", 1)
vas:addSound("friendly_lowhp", 1)

vas:addSound("weapon_ready", 1)
vas:addSound("weapon_fire", 1)

vas:addSound("space_drone_launch", 1)
vas:addSound("space_drone_destroyed", 1)

vas:addSound("shield_damaged", 1)
vas:addSound("shield_ion", 1)
vas:addSound("shield_destroyed", 1)
vas:addSound("shield_hacked", 1)

vas:addSound("weapon_damaged", 1)
vas:addSound("weapon_ion", 1)
vas:addSound("weapon_destroyed", 1)
vas:addSound("weapon_hacked", 1)

vas:addSound("engine_damaged", 1)
vas:addSound("engine_ion", 1)
vas:addSound("engine_destroyed", 1)
vas:addSound("engine_hacked", 1)

vas:addSound("pilot_damaged", 1)
vas:addSound("pilot_ion", 1)
vas:addSound("pilot_destroyed", 1)
vas:addSound("pilot_hacked", 1)

vas:addSound("cloak_damaged", 1)
vas:addSound("cloak_ion", 1)
vas:addSound("cloak_destroyed", 1)
vas:addSound("cloak_hacked", 1)

vas:addSound("artilery_damaged", 1)
vas:addSound("artilery_ion", 1)
vas:addSound("artilery_destroyed", 1)
vas:addSound("artilery_hacked", 1)

vas:addSound("drone_damaged", 1)
vas:addSound("drone_ion", 1)
vas:addSound("drone_destroyed", 1)
vas:addSound("drone_hacked", 1)

vas:addSound("mind_damaged", 1)
vas:addSound("mind_ion", 1)
vas:addSound("mind_destroyed", 1)
vas:addSound("mind_hacked", 1)

vas:addSound("sensor_damaged", 1)
vas:addSound("sensor_ion", 1)
vas:addSound("sensor_destroyed", 1)
vas:addSound("sensor_hacked", 1)

vas:addSound("oxygen_damaged", 1)
vas:addSound("oxygen_ion", 1)
vas:addSound("oxygen_destroyed", 1)
vas:addSound("oxygen_hacked", 1)

vas:addSound("teleporter_damaged", 1)
vas:addSound("teleporter_ion", 1)
vas:addSound("teleporter_destroyed", 1)
vas:addSound("teleporter_hacked", 1)

vas:addSound("battery_damaged", 1)
vas:addSound("battery_ion", 1)
vas:addSound("battery_destroyed", 1)
vas:addSound("battery_hacked", 1)

vas:addSound("hacking_damaged", 1)
vas:addSound("hacking_ion", 1)
vas:addSound("hacking_destroyed", 1)
vas:addSound("hacking_hacked", 1)

vas:addSound("temporal_damaged", 1)
vas:addSound("temporal_ion", 1)
vas:addSound("temporal_destroyed", 1)
vas:addSound("temporal_hacked", 1)

vas:addSound("hull_alert_75", 1)
vas:addSound("hull_alert_50", 1)
vas:addSound("hull_alert_25", 1)

vas:addSound("jumping_nocombat", 1)
vas:addSound("jumping_combat", 1)
vas:addSound("pause_true", 1)
vas:addSound("pause_false", 1)

function vas:removeSound(sound)
    for i, v in ipairs(vas.sound_queue) do
        if v == sound then
            table.remove(vas.sound_queue, i)
            return
        end
    end
end

function vas:playSound(sound)
    if not vas.hookSounds[sound] then return end
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