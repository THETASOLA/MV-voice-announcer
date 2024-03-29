local vas = mods.vasystem or {}

script.on_internal_event(Defines.InternalEvents.SHIP_LOOP, function(ship)

end)

script.on_internal_event(Defines.InternalEvents.PROJECTILE_FIRE, function(proj, weapon)
    
end)

script.on_internal_event(Defines.InternalEvents.DAMAGE_AREA_HIT, function(ship, proj, loc, damage)
    if ship ~= Hyperspace.ship.player then return end

    local room = ship.ship:GetSelectedRoomId(loc.x, loc.y, true)
    local systemHit = ship:GetSystemInRoom(room)

    if systemHit then
        
    end

    return Defines.Chain.Continue
end)