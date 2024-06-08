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

local function system_damage(ship, _, roomId, damage)
    if Hyperspace.ships.enemy == ship then return end

    local system = ship:GetSystemInRoom(roomId)
    local sys_name = system_name[system.iSystemType]
    if damage.iDamage > 0 then
        if system.fMaxDamage - system.fDamage <= damage.iDamage then
            vas:playSound(sys_name.."_destroyed")
            return
        end
        vas:playSound("system_damaged")
    elseif damage.iIonDamage > 0 then
        vas:playSound("system_ion")
    end
end

local function hull_damage(shipM, _, loc, damage)
    if Hyperspace.ships.enemy == ship then return end

    local ship = shipM.ship

    if damage.iDamage > 0 then
        local life_ratio = (ship.hullIntegrity.first - damage.iDamage) / ship.hullIntegrity.second
        if life_ratio <= 0.25 then
            vas:playSound("hull_alert_25")
        elseif life_ratio <= 0.5 then
            vas:playSound("hull_alert_50")
        elseif life_ratio <= 0.75 then
            vas:playSound("hull_alert_75")
        end
    end
end

local function jump_away(ship)
    if Hyperspace.ships.enemy == ship then return end

    if Hyperspace.ships.enemy then
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
end


script.on_internal_event(Defines.InternalEvents.DAMAGE_SYSTEM, system_damage)
script.on_internal_event(Defines.InternalEvents.DAMAGE_AREA_HIT, hull_damage)
script.on_internal_event(Defines.InternalEvents.JUMP_LEAVE, jump_away)
script.on_internal_event(Defines.InternalEvents.SHIP_LOOP, ship_loop)
