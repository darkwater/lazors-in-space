Shield = class("Shield", Entity)

---
-- Shield:initialize
-- Creates a shield to protect an entity.
--
-- @param body      Physics body to attach the shield to
-- @param size      Radius of the shield
-- @param max       Maximum energy of the shield
--
function Shield:initialize(body, size, max)

    self.max = max
    self.level = max
    self.size = size
    self.body = body

end


---
-- Shield:update
-- Updates the shield
--
function Shield:update(dt)

    self.level = math.min(self.max, self.level + dt / 5)

end


---
-- Shield:draw
-- Draws an outlined circle, you should override this in a subclass.
--
function Shield:draw()

    love.graphics.setColor(200, 200, 200, 150)
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.size - 2, 30)

    love.graphics.setColor(150, 200, 255, 250)
    -- love.graphics.arc("line", self.body:getX(), self.body:getY(), self.size + 2, 0, self.level / self.max * math.pi * 2, 30) -- shield ~= pacman!  :<

    local vertices = {}
    local x, y = self.body:getX(), self.body:getY()

    for i = 0, math.ceil(self.level / self.max * 36) do

        local theta = math.min(i * 10 / 180 * math.pi, self.level / self.max * math.pi * 2)

        table.insert(vertices, x + math.cos(theta) * self.size)
        table.insert(vertices, y + math.sin(theta) * self.size)

    end

    if #vertices >= 4 then

        love.graphics.line(unpack(vertices))

    end

end


---
-- Shield:takeDamage
-- Subtract hitpoints.
--
-- @param hp        Amount of damage to subtract
--
function Shield:takeDamage(hp)

    if not hp then return end 

    self.level = math.max(0, self.level - hp)

end


---
-- Shield:takeDamage
-- Subtract hitpoints.
--
-- @returns bool    True if the shield's level is less than 1, false otherwise
function Shield:isEmpty()

    return self.level < 1

end
