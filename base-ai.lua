BaseAI = class("BaseAI", CircleEntity)

---
-- BaseAI:initialize
-- A simple base AI, currently used for testing.
--
-- @param x         X position
-- @param y         Y position
--
function BaseAI:initialize(x, y)
    CircleEntity.initialize(self, x, y, "dynamic", 10)

    self.fixture:setGroupIndex(colgroup.ENEMY)

    self.damage = 1
    self.points = 0
end


---
-- BaseAI:update
-- Updates the BaseAI.
--
-- @param dt        Time passed since last frame
--
function BaseAI:update(dt)

end


---
-- BaseAI:draw
-- Draws the BaseAI.
--
function BaseAI:draw()

end


---
-- BaseAI:impact
-- Gets called whenever there's a collision with another entity.
--
-- @param ent       The entity collided with
-- @param contact   The contact object of the collision
--
function BaseAI:impact(ent, contact)
    local hp = ent.damage or 0
    if hp > 0 then
        sounds.play("enemy_hit")

        if not self.shield:isEmpty() then
            self.shield:takeDamage(hp)
        else
            self:destroy()
            game.points = game.points + self.points
        end
    end
end


---
-- BaseAI:moveInDirection
-- Move the BaseAI into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param speed     Speed
--
function BaseAI:moveInDirection(ang, speed)
    if not speed then speed = 1 end

    self.body:applyForce(math.cos(ang) * speed, math.sin(ang) * speed)
end


---
-- BaseAI:pushInDirection
-- Pushes the BaseAI into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param force     Force
--
function BaseAI:pushInDirection(ang, force)
    if not force then force = 1 end

    self.body:applyLinearImpulse(math.cos(ang) * force, math.sin(ang) * force)
end


---
-- BaseAI:aimInDirection
-- Aims the BaseAI into a specific direction
--
-- @param ang       The angle of the direction (radians)
--
function BaseAI:aimInDirection(ang)
    self.body:setAngle(ang)
end
