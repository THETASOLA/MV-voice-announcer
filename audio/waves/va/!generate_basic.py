from gtts import gTTS
import os

sound = {
    "entering_pulsar": "Entering pulsar",
    "entering_sun": "Entering sun vicinity",
    "entering_storm": "Entering asteroid field",
    "entering_nebula": "Entering nebula",
    "fire_start": "Fire detected",
    "low_oxygen": "Low oxygen detected",
    "asb_detected": "ASB detected",
    "asb_willhit": "ASB on hit vector",

    "boarder_enemy": "Enemy boarder detected",
    "boarder_friendly": "Friendly boarder detected",
    "mc_enemy": "Mind controlling enemy",
    "mc_friendly": "Friendly mind controlled",
    "friendly_lowhp": "Friendly low health",
    "friendly_power_ready": "Friendly power ready",

    "weapon_ready": "Weapon ready",
    "weapon_fire": "Weapon firing",

    "space_drone_launch": "Launching drone",
    "space_drone_destroyed": "Drone destroyed",

    "shield_damaged": "Shield damaged",
    "shield_ion": "Shield ionized",
    "shield_destroyed": "Shield destroyed",
    "shield_hacked": "Shield hacked",

    "weapon_damaged": "Weapon damaged",
    "weapon_ion": "Weapon ionized",
    "weapon_destroyed": "Weapon destroyed",
    "weapon_hacked": "Weapon hacked",

    "engine_damaged": "Engine damaged",
    "engine_ion": "Engine ionized",
    "engine_destroyed": "Engine destroyed",
    "engine_hacked": "Engine hacked",

    "pilot_damaged": "Pilot system damaged",
    "pilot_ion": "Pilot system ionized",
    "pilot_destroyed": "Pilot system destroyed",
    "pilot_hacked": "Pilot system hacked",

    "cloak_damaged": "Cloaking damaged",
    "cloak_ion": "Cloaking ionized",
    "cloak_destroyed": "Cloaking destroyed",
    "cloak_hacked": "Cloaking hacked",

    "artilery_damaged": "Artillery damaged",
    "artilery_ion": "Artillery ionized",
    "artilery_destroyed": "Artillery destroyed",
    "artilery_hacked": "Artillery hacked",

    "drone_damaged": "Drone control damaged",
    "drone_ion": "Drone control ionized",
    "drone_destroyed": "Drone control destroyed",
    "drone_hacked": "Drone control hacked",

    "mind_damaged": "Mind control damaged",
    "mind_ion": "Mind control ionized",
    "mind_destroyed": "Mind control destroyed",
    "mind_hacked": "Mind control hacked",

    "sensor_damaged": "Sensors damaged",
    "sensor_ion": "Sensors ionized",
    "sensor_destroyed": "Sensors destroyed",
    "sensor_hacked": "Sensors hacked",

    "oxygen_damaged": "Oxygen system damaged",
    "oxygen_ion": "Oxygen system ionized",
    "oxygen_destroyed": "Oxygen system destroyed",
    "oxygen_hacked": "Oxygen system hacked",

    "teleporter_damaged": "Teleporter damaged",
    "teleporter_ion": "Teleporter ionized",
    "teleporter_destroyed": "Teleporter destroyed",
    "teleporter_hacked": "Teleporter hacked",

    "battery_damaged": "Battery damaged",
    "battery_ion": "Battery ionized",
    "battery_destroyed": "Battery destroyed",
    "battery_hacked": "Battery hacked",

    "hacking_damaged": "Hacking system damaged",
    "hacking_ion": "Hacking system ionized",
    "hacking_destroyed": "Hacking system destroyed",
    "hacking_hacked": "Hacking system hacked",

    "temporal_damaged": "Temporal system damaged",
    "temporal_ion": "Temporal system ionized",
    "temporal_destroyed": "Temporal system destroyed",
    "temporal_hacked": "Temporal system hacked",

    "hull_alert_75": "Hull integrity at 75%",
    "hull_alert_50": "Hull integrity at 50%",
    "hull_alert_25": "Hull integrity at 25%",

    "jumping_nocombat": "Jumping to next sector",
    "jumping_combat": "Jumping during combat",
    "pause_true": "Game paused",
    "pause_false": "Game resumed"
}

for key, value in sound.items():
    tts = gTTS(text=value, lang='en')
    tts.save(f"{key}_1.ogg")
    print(f"Saved {key}.ogg")

