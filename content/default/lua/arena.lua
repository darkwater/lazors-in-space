Arena = class("Arena")

---
-- Arena:initialize
-- A survival arena.
--
function Arena:initialize()

    self.size = 1500

    self.nextSpawn = 0
    self.spawnInterval = 1          -- Seconds between spawns
    self.spawnIntervalRamp = -0.1  -- Change per difficulty
    self.spawnIntervalFloor = 0.1   -- Minimum interval
    self.difficulty = 1
    self.difficultyRamp = 0.1       -- Change per second

end

Arena.static.enemies =
{

}


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
-- Arena:randomEnemy
-- Returns a random enemy for the given difficulty
--
-- @param difficulty    Difficulty to get random enemy for, defaults to self.difficulty
--
function Arena:randomEnemy(difficulty)

    if not difficulty then difficulty = self.difficulty end

    return ({ Pont, Bute })[math.random(1,2)]

end


---
-- Arena:update
-- Occasionally spawns enemies.
--
-- @param dt        Time passed since last frame
--
function Arena:update(dt)

    self.difficulty = self.difficulty + self.difficultyRamp * dt

    if game.time >= self.nextSpawn then

        self:randomEnemy():new(self:randomPoint())

        self.nextSpawn = game.time + math.ceil(self.spawnInterval + self.spawnIntervalRamp * self.difficulty, self.spawnIntervalFloor)

    end

end


---
-- Arena:draw
-- Shows a difficulty display
--
function Arena:draw()

    love.graphics.setColor(200, 230, 255, 200)
    love.graphics.print("Difficulty: " .. math.floor(self.difficulty * 100) / 100, 10, love.window.getHeight() - 50)

end

return Arena
