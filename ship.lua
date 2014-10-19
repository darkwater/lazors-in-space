Ship = class('Ship', CircleEntity)

---
-- Ship:initialize
-- The main ship which can be controller by the player.
--
-- @param x         X position
-- @param y         Y position
--
function Ship:initialize(x, y)

    Entity.initialize(self, x, y, 'dynamic', love.physics.newCircleShape(15))
    self.speed = 500
    -- self.turnSspeed = 500
    self.body:setLinearDamping(10)
    self.body:setAngularDamping(1)

    self.fixture:setGroupIndex(colgroup.PLAYER)

    self.nextFire = 0
    self.fireInterval = 0.1
    self.fireSpread = false -- to toggle between double/single shot
    self.spread = 0.1 -- TODO: change spread according to distance of mouse?

    self.damage = 5

    self.shield = Shield:new(self.body, 22, 300)

    self.rumbleObjects = {}

    self.keyboardEnabled  = true
    self.mouseEnabled     = true
    self.joystickEnabled  = false

    if love.joystick.getJoystickCount() > 0 and self.joystickEnabled then

        self.joystick = love.joystick.getJoysticks()[1]

        self.joystickDeadzone = 0.25

        self:rumble(0.5, 0, 0.1)
        print(self.joystick:getName() .. " connected!")

        if not self.joystick:isVibrationSupported() then

            print("It doesn't support rumble, though. :<")

        end

    end

end


---
-- Ship:update
-- Updates the ship.
--
-- @param dt        Time passed since last frame
--
function Ship:update(dt)

    local mx, my = 0, 0

    if self.keyboardEnabled then

        my = my + (love.keyboard.isDown('w') and -1 or 0)
        my = my + (love.keyboard.isDown('s') and  1 or 0)
        mx = mx + (love.keyboard.isDown('a') and -1 or 0)
        mx = mx + (love.keyboard.isDown('d') and  1 or 0)

    end

    if self.joystickEnabled then

        mx = mx + self.joystick:getAxis(1)
        my = my + self.joystick:getAxis(2)

        local dx = self.joystick:getAxis(3)
        local dy = self.joystick:getAxis(4)

        if math.abs(dx) > self.joystickDeadzone or math.abs(dy) > self.joystickDeadzone  then

            self:aimInDirection(math.atan2(dy, dx))
            self:fire()

        end

    end

    if mx ~= 0 or my ~= 0 then

        local ang  = math.atan2(my, mx)
        local dist = math.clamp(-1, math.sqrt(mx ^ 2 + my ^ 2), 1)

        if not self.joystickEnabled or dist > self.joystickDeadzone then

            self:moveInDirection(ang, dist)

        end

    end


    if self.mouseEnabled then

        if love.window.hasMouseFocus() then

            local dx = game.mousex - self.body:getX()
            local dy = game.mousey - self.body:getY()
            self:aimInDirection(math.atan2(dy, dx))

        end


        if love.mouse.isDown('l') then

            self:fire()

        end

    end


    local rumbleForce = 0

    for k,v in pairs(self.rumbleObjects) do

        rumbleForce = rumbleForce + v.force
        v.force = v.force - v.delta * dt
        v.duration = v.duration - dt

        if v.duration <= 0 then

            self.rumbleObjects[k] = nil

        end

    end

    rumbleForce = math.min(rumbleForce, 1)

    game.camerax = game.camerax + math.random(-rumbleForce * 10, rumbleForce * 10)
    game.cameray = game.cameray + math.random(-rumbleForce * 10, rumbleForce * 10)

    if self.joystickEnabled and self.joystick:isVibrationSupported() then

        self.joystick:setVibration(rumbleForce, rumbleForce)

    end


    self.shield:update(dt)

end


---
-- Ship:impact
-- Gets called whenever there's a collision with another entity.
--
-- @param ent       The entity collided with
-- @param contact   The contact object of the collision
--
function Ship:impact(ent, contact)

    if ent.damage and ent.damage > 0 then

        sounds.play('player_hit')

        if not self.shield:isEmpty() then

            self:rumble(0.2, 0, ent.damage / 5)

            self.shield:takeDamage(ent.damage)

        else

            game.over = true

            if self.joystickEnabled then self.joystick:setVibration(0, 0) end

            self.rumbleObjects = {}

        end

    end

end


---
-- Ship:draw
-- Draws the ship.
--
function Ship:draw()

    love.graphics.setColor(255, 50, 50) -- temporary
    love.graphics.circle('line', self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
    love.graphics.line(self.body:getX(), self.body:getY(), self.body:getWorldPoint(15, 0))
    self.shield:draw()

end


---
-- Ship:moveInDirection
-- Move the ship into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param speedMul  Speed multiplier, 1 is normal speed
--
function Ship:moveInDirection(ang, speedMul)

    if not speedMul then speedMul = 1 end

    self.body:applyForce(math.cos(ang) * self.speed * speedMul, math.sin(ang) * self.speed * speedMul)

end


---
-- Ship:aimInDirection
-- Aims the ship into a specific direction
--
-- @param ang       The angle of the direction (radians)
--
function Ship:aimInDirection(ang)

    self.body:setAngle(ang)

end


---
-- Ship:shoot
-- Shoots a bullet
--
-- @param ang       The direction of the bullet (radians)
--
function Ship:shoot(ang)

    local dx = math.cos(ang) * 15
    local dy = math.sin(ang) * 15
    Bullet:new(self.body:getX() + dx, self.body:getY() + dy, ang, 18, colgroup.PLAYER, love.physics.newPolygonShape(20,0 , 0,6 , 0,-6))

end


---
-- Ship:fire
-- Shoots if possible
--
function Ship:fire()

    if self.nextFire <= game.time then

        self.nextFire = game.time + self.fireInterval

        if self.fireSpread then

            self:shoot(self.body:getAngle() + self.spread)
            self:shoot(self.body:getAngle() - self.spread)

        else

            self:shoot(self.body:getAngle())

        end

        self.fireSpread = not self.fireSpread

        sounds.play('player_shoot')

    end

end


---
-- Ship:shoot
-- Shoots a bullet
--
-- @param startForce    Intensity of the rumble
-- @param endForce      Intensity to fade to after duration
-- @param duration      Time until intensity has faded to endForce
--
function Ship:rumble(startForce, endForce, duration)

    table.insert(self.rumbleObjects, { force = startForce, duration = duration, delta = 1 / duration * (startForce - endForce) })

end
