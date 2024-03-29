mods.vasystem = {}
local vas = mods.vasystem

vas.sound_queue = {}
vas.sound_queue_max = 5
vas.sound_queue_set_cd = 3 --I don't want the voiceline to overlap
vas.sound_queue_cd = 0

vas.hookSounds = {
    --Usual hazard
    ["entering_pulsar"] = 1,
    ["entering_sun"] = 1,
    ["entering_asteroid"] = 1,
    ["fire_start"] = 1,
    ["breach_start"] = 1,
    ["asb_detected"] = 1,
    ["asb_willhit"] = 1,

    --Boarding
    ["boarder_enemy"] = 1,
    ["boarder_friendly"] = 1,
    ["mc_enemy"] = 1,
    ["mc_friendly"] = 1,
    ["friendly_lowhp"] = 1,
    ["friendly_power_ready"] = 1,

    --Weapon
    ["weapon_ready"] = 1,
    ["weapon_fire"] = 1,

    --Drone
    ["drone_launch"] = 1,
    ["drone_destroyed"] = 1,

    --System
    ["shield_damaged"] = 1,
    ["shield_ion"] = 1,
    ["shield_destroyed"] = 1,
    ["shield_hacked"] = 1,

    ["weapon_damaged"] = 1,
    ["weapon_ion"] = 1,
    ["weapon_destroyed"] = 1,
    ["weapon_hacked"] = 1,

    ["reactor_damaged"] = 1,
    ["reactor_ion"] = 1,
    ["reactor_destroyed"] = 1,
    ["reactor_hacked"] = 1,

    ["piloting_damaged"] = 1,
    ["piloting_ion"] = 1,
    ["piloting_destroyed"] = 1,
    ["piloting_hacked"] = 1,

    ["cloak_damaged"] = 1,
    ["cloak_ion"] = 1,
    ["cloak_destroyed"] = 1,
    ["cloak_hacked"] = 1,

    ["artilery_damaged"] = 1,
    ["artilery_ion"] = 1,
    ["artilery_destroyed"] = 1,
    ["artilery_hacked"] = 1,

    ["dronebay_damaged"] = 1,
    ["dronebay_ion"] = 1,
    ["dronebay_destroyed"] = 1,
    ["dronebay_hacked"] = 1,

    ["mc_damaged"] = 1,
    ["mc_ion"] = 1,
    ["mc_destroyed"] = 1,
    ["mc_hacked"] = 1,

    ["sensors_damaged"] = 1,
    ["sensors_ion"] = 1,
    ["sensors_destroyed"] = 1,
    ["sensors_hacked"] = 1,

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

    --Ship Status
    ["hull_alert"] = 1,
    ["hull_alert_2"] = 1,
    ["hull_alert_3"] = 1,

    --Action
    ["jumping_nocombat"] = 1,
    ["jumping_combat"] = 1,
    ["pause_active"] = 1,
    ["pause_inactive"] = 1,
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
    Hyperspace:GetSoundControl():PlaySoundMix(sound.."_"..tostring(num), -1, false)
    vas.sound_queue_cd = vas.sound_queue_set_cd
end

function vas:clearQueue()
    vas.sound_queue = {}
end

script.on_internal_event(Defines.InternalEvents.ON_TICK, function()
    vas.sound_queue_cd = math.max(vas.sound_queue_cd - Hyperspace.FPS.SpeedFactor/16, 0)
    if #vas.sound_queue == 0 or vas.sound_queue_cd ~= 0 then return end

    vas:playSoundQueue()
end)