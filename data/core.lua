mods.vasystem = {}
local vas = mods.vasystem

vas.sound_queue = {}
vas.sound_queue_max = 5
vas.sound_queue_set_cd = 3 --I don't want the voiceline to overlap
vas.sound_queue_cd = 0

vas.hookSounds = {
    --Usual hazard
    ["entering_pulsar"] = "",
    ["entering_sun"] = "",
    ["entering_asteroid"] = "",
    ["fire_start"] = "",
    ["breach_start"] = "",
    ["asb_detected"] = "",
    ["asb_willhit"] = "",

    --Boarding
    ["boarder_enemy"] = "",
    ["boarder_friendly"] = "",
    ["mc_enemy"] = "",
    ["mc_friendly"] = "",
    ["friendly_lowhp"] = "",
    ["friendly_power_ready"] = "",

    --Weapon
    ["weapon_ready"] = "",
    ["weapon_fire"] = "",

    --Drone
    ["drone_launch"] = "",
    ["drone_destroyed"] = "",

    --System
    ["shield_damaged"] = "",
    ["shield_ion"] = "",
    ["shield_destroyed"] = "",
    ["shield_hacked"] = "",

    ["weapon_damaged"] = "",
    ["weapon_ion"] = "",
    ["weapon_destroyed"] = "",
    ["weapon_hacked"] = "",

    ["reactor_damaged"] = "",
    ["reactor_ion"] = "",
    ["reactor_destroyed"] = "",
    ["reactor_hacked"] = "",

    ["piloting_damaged"] = "",
    ["piloting_ion"] = "",
    ["piloting_destroyed"] = "",
    ["piloting_hacked"] = "",

    ["cloak_damaged"] = "",
    ["cloak_ion"] = "",
    ["cloak_destroyed"] = "",
    ["cloak_hacked"] = "",

    ["artilery_damaged"] = "",
    ["artilery_ion"] = "",
    ["artilery_destroyed"] = "",
    ["artilery_hacked"] = "",

    ["dronebay_damaged"] = "",
    ["dronebay_ion"] = "",
    ["dronebay_destroyed"] = "",
    ["dronebay_hacked"] = "",

    ["mc_damaged"] = "",
    ["mc_ion"] = "",
    ["mc_destroyed"] = "",
    ["mc_hacked"] = "",

    ["sensors_damaged"] = "",
    ["sensors_ion"] = "",
    ["sensors_destroyed"] = "",
    ["sensors_hacked"] = "",

    ["oxygen_damaged"] = "",
    ["oxygen_ion"] = "",
    ["oxygen_destroyed"] = "",
    ["oxygen_hacked"] = "",

    ["teleporter_damaged"] = "",
    ["teleporter_ion"] = "",
    ["teleporter_destroyed"] = "",
    ["teleporter_hacked"] = "",

    ["battery_damaged"] = "",
    ["battery_ion"] = "",
    ["battery_destroyed"] = "",
    ["battery_hacked"] = "",

    ["hacking_damaged"] = "",
    ["hacking_ion"] = "",
    ["hacking_destroyed"] = "",
    ["hacking_hacked"] = "",

    --Ship Status
    ["hull_alert"] = "",
    ["hull_alert_2"] = "",
    ["hull_alert_3"] = "",

    --Action
    ["jumping_nocombat"] = "",
    ["jumping_combat"] = "",
    ["pause_active"] = "",
    ["pause_inactive"] = "",
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
    Hyperspace:GetSoundControl():PlaySoundMix(sound, -1, false)
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