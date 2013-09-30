BulletImpact = class("BulletImpact")

---
-- BulletImpact:initialize
-- The bullet impact effect.
--
-- @param x         X position
-- @param y         Y position
--
-- @returns nil     Nothing
function BulletImpact:initialize(x, y)
    self.x          = x
    self.y          = y
    self.life       = 0
    self.particleid = game.addParticle(self)
    self.speed      = math.random(40, 70)
    self.particles  = math.random(5, 12)
end


---
-- BulletImpact:update
-- Updates the bullet impact effect.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function BulletImpact:update(dt)
    self.life = self.life + dt
    if self.life > 0.2 then
        self:destroy()
    end
end


---
-- BulletImpact:draw
-- Draws the bullet impact effect.
--
-- @returns nil     Nothing
function BulletImpact:draw()
    love.graphics.setColor(255, 250, 240, 200)

    local dist1, dist2 = self.life * self.speed * 0.6, self.life * self.speed * 1.4

    for i = 1, self.particles do                       -- bonus randomness!
        local theta = i / self.particles * math.pi*2 + self.speed

        love.graphics.line(self.x + math.cos(theta) * dist1, self.y + math.sin(theta) * dist1,
                           self.x + math.cos(theta) * dist2, self.y + math.sin(theta) * dist2)
    end
end


---
-- BulletImpact:destroy
-- Destroys the effect.
--
-- @returns nil     Nothing
function BulletImpact:destroy()
    game.particles[self.particleid] = nil
    self = nil
end
