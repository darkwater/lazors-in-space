Arena = class("Arena")

---
-- Arena:initialize
-- A survival arena.
--
function Arena:initialize()

    self.size = 1500

end


---
-- Arena:randomPoint
-- Returns a random point within the arena.
--
function Arena:randomPoint()

    local bounds = self.size - 10
    local x = math.random(-bounds, bounds)
    local y = math.random(-bounds + math.abs(x), bounds - math.abs(x))

    return x, y

end


---
-- Arena:update
-- Occasionally spawns enemies.
--
-- @param dt        Time passed since last frame
--
function Arena:update(dt)

    Pont:new(self:randomPoint())

end

return Arena
