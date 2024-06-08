local vas = mods.vasystem

local function userdata_table(userdata, tableName)
    if not userdata.table[tableName] then userdata.table[tableName] = {} end
    return userdata.table[tableName]
end

local function vter(cvec)
    local i = -1
    local n = cvec:size()
    return function()
        i = i + 1
        if i < n then return cvec[i] end
    end
end

local system_name = {
    [0] = "shield",
    [1] = "engine",
    [2] = "oxygen",
    [3] = "weapon",
    [4] = "drone",
    [5] = "medbay",
    [6] = "pilot",
    [7] = "sensor",
    [8] = "door",
    [9] = "teleporter",
    [10] = "cloak",
    [11] = "artillery",
    [12] = "battery",
    [13] = "clonebay",
    [14] = "mind",
    [15] = "hacking",
    [20] = "temporal"
}

local fire_delay = 0

local function system_damage(ship, _, roomId, damage)
    if Hyperspace.ships.enemy == ship then return end

    local system
    for sys in vter(ship.vSystemList) do
        if sys:GetRoomId() == roomId then
            system = sys
            break
        end
    end

    if not system then return end
    local sys_name = system_name[system.iSystemType]

    if damage.iDamage > 0 and system.healthState.first ~= 0 then
        if system.healthState.second - system.healthState.first >= damage.iDamage then
            vas:playSound(sys_name.."_destroyed")
        else
            vas:playSound(sys_name.."_damaged")
        end
    elseif damage.iIonDamage > 0 then
        vas:playSound(sys_name.."_ion")
    end

    return Defines.Chain.Continue
end

local function hull_damage(shipM, _, loc, damage)
    if Hyperspace.ships.enemy == shipM then return end

    local ship = shipM.ship

    if damage.iDamage > 0 then
        local old_life_ratio = ship.hullIntegrity.first / ship.hullIntegrity.second
        local life_ratio = (ship.hullIntegrity.first - damage.iDamage) / ship.hullIntegrity.second

        if life_ratio <= 0.25 and old_life_ratio > 0.25 then
            vas:playSound("hull_alert_25")
        elseif life_ratio <= 0.5 and old_life_ratio > 0.5 then
            vas:playSound("hull_alert_50")
        elseif life_ratio <= 0.75 and old_life_ratio > 0.75 then
            vas:playSound("hull_alert_75")
        end
    end

    return Defines.Chain.Continue
end

local function jump_away(ship)
    if Hyperspace.ships.enemy == ship then return end

    if Hyperspace.ships.enemy then -- TODO identify if the player is fighting when jumping 
        vas:playSound("jumping_combat")
    else
        vas:playSound("jumping_nocombat")
    end
end

local last_pause = false

local function ship_loop(ship)
    if Hyperspace.ships.enemy == ship then return end

    -- Pause handling
    local gui = Hyperspace.App.gui
    if gui.bPaused ~= last_pause then
        last_pause = gui.bPaused
        if last_pause then
            vas:playSound("pause_true")
        else
            vas:playSound("pause_false")
        end
    end

    -- Weapon Charge handling
    for weapon in vter(ship:GetWeaponList()) do
        local userdata_weapon = userdata_table(weapon, "mods.vasystem.weapons_charge")
        if weapon.cooldown.first == weapon.cooldown.second and userdata_weapon.charge ~= weapon.cooldown.first then
            vas:playSound("weapon_charge")
        end
        userdata_weapon.charge = weapon.cooldown.first
    end

    -- System Hacked
    for system in vter(ship.vSystemList) do
        local userdata_system = userdata_table(system, "mods.vasystem.systems_hacked")
        if system.iHackEffect > 0 and system.iHackEffect ~= userdata_system.hacked then
            vas:playSound(system_name[system.iSystemType].."_hacked")
        end
        userdata_system.hacked = system.iHackEffect
    end

    -- Delays for other functions
    fire_delay = math.max(fire_delay - Hyperspace.FPS.SpeedFactor/16, 0)
end


local function weapon_fire(_, weapon)
    if weapon.iShipId == 1 or fire_delay ~= 0 then return end

    vas:playSound("weapon_fire")
    fire_delay = 2
end

local function crew_loop(crew)
    local userdata_crew = userdata_table(crew, "mods.vasystem.crew")
    local enemy = crew.iShipId == 1

    if crew.bMindControlled == 1 and crew.bMindControlled ~= userdata_crew.mind_controlled then
        if enemy then
            vas:playSound("mc_enemy")
        else
            vas:playSound("mc_friendly")
        end
    end
    userdata_crew.mind_controlled = crew.bMindControlled

    if crew.currentShipId ~= crew.iShipId and crew.currentShipId ~= userdata_crew.shipID then
        if enemy then
            vas:playSound("boarder_enemy")
        else
            vas:playSound("boarder_friendly")
        end
    end
    userdata_crew.shipID = crew.currentShipId

    if enemy then return end
    userdata_crew.low_hp_alert = userdata_crew.low_hp_alert or false

    if (crew.health.first / crew.health.second) <= 0.25 and not userdata_crew.low_hp_alert then
        vas:playSound("friendly_lowhp")
        userdata_crew.low_hp_alert = true
    end

    if (crew.health.first / crew.health.second) > 0.25 then
        userdata_crew.low_hp_alert = false
    end
end

--System
script.on_internal_event(Defines.InternalEvents.DAMAGE_SYSTEM, system_damage)

--Ship Status
script.on_internal_event(Defines.InternalEvents.DAMAGE_AREA_HIT, hull_damage)

--Action
script.on_internal_event(Defines.InternalEvents.JUMP_LEAVE, jump_away)

--Weapon
script.on_internal_event(Defines.InternalEvents.PROJECTILE_FIRE, weapon_fire)

--Boarding
script.on_internal_event(Defines.InternalEvents.CREW_LOOP, crew_loop)

--Action/Weapon
script.on_internal_event(Defines.InternalEvents.SHIP_LOOP, ship_loop)