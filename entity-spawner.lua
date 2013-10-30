EntitySpawner = class("EntitySpawner")

---
-- EntitySpawner:initialize
-- A simple entity spawner.
--
-- @param x         X position
-- @param y         Y position
-- @param entity    The name of the entity to spawn
-- @param params    Parameters used to spawn the entity
-- @param interval  Interval between spawning. Also accepts a table {min, max} for randomized intervals
-- @param amount    Amount of entities to spawn. Also accepts a table {min, max} for randomized amount
--
function EntitySpawner:initialize(x, y, entity, params, interval, amount)
    if type(interval) == "number" then interval = {interval, interval} end
    if type(amount) == "number" then amount = {amount, amount} end

    self.x = x
    self.y = y
    self.entity = entity
    self.params = params
    self.interval = interval
    self.amount = amount

    self.objectid = game.addObject(self)

    self.nextFire = 0
end


---
-- EntitySpawner:update
-- Spawns an entity if needed.
--
function EntitySpawner:update(dt)
    if game.time >= self.nextFire then
        for i=1, math.random(unpack(self.amount)) do
            _G[self.entity]:new(self.x, self.y)
        end

        self.nextFire = game.time + math.random() * (self.interval[2] - self.interval[1]) + self.interval[1]
    end
end


---
-- EntitySpawner:draw
-- Does nothing.
--
function EntitySpawner:draw()

end
