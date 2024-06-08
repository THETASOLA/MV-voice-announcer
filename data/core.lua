mods.vasystem = {}
local vas = mods.vasystem

vas.sound_queue = {}
vas.sound_queue_max = 5
vas.sound_queue_set_cd = 3 --I don't want the voiceline to overlap
vas.sound_queue_cd = 0

vas.hookSounds = {
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
}

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
    local num = math.random(1, vas.hookSounds[sound])
    local sound_path = sound.."_"..tostring(num)
    print("Playing sound: "..sound)
    Hyperspace.Sounds:PlaySoundMix(sound, -1, false)
    vas.sound_queue_cd = vas.sound_queue_set_cd
end

function vas:clearQueue()
    vas.sound_queue = {}
end

function vas:removeSound(sound)
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