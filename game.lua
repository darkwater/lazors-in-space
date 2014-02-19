--== General ==--

    game = {}
    game.time = 0
    game.over = false
    game.world = love.physics.newWorld(0, 0, true)
    game.mousepressed = {}
    game.mousereleased = {}
    game.afterWorldUpdate = {}
    setmetatable(game.afterWorldUpdate, {
        __call = function (self, func)
            table.insert(game.afterWorldUpdate, func)
        end
    })

    game.points = 0

    game.camerax = 0
    game.cameray = 0
    game.zoom = 1
    game.zoomtarget = 1

-----------------

--== Objects ==--

    game.objects = {}
    game.nextObjectId = 1

    game.addObject = function (obj)

        local id = game.nextObjectId
        game.nextObjectId = game.nextObjectId + 1
        game.objects[id] = obj
        return id

    end

-----------------

--== Particles ==--

    game.particles = {}
    game.nextParticleId = 1

    game.addParticle = function (part)

        local id = game.nextParticleId
        game.nextParticleId = game.nextParticleId + 1
        game.particles[id] = part
        return id

    end

-------------------

--== Background ==--

    game.background = {}

    for i = 1, 5000 do

        table.insert(game.background,
        {
            parallax = math.random(1, 300) / 10000,
            x = math.random(-3000, 3000),
            y = math.random(-2000, 2000),
            r = math.random(200, 255),
            g = math.random(200, 255),
            b = math.random(200, 255)
        })

    end

--------------------

-- Should move this to the Map class

    -- game.map = Map:new()
    -- game.map:loadMap(arg[2] or "content/default/maps/arena")

    -- game.ship = Ship:new(0, 0)

    -- game.world:setCallbacks(function (fix1, fix2, contact) -- beginContact

    --     local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

    --     if not ent1 or not ent2 then return end -- this never happened ok?

    --     if ent1.impact and not fix2:isSensor() then ent1:impact(ent2, contact) end
    --     if ent2.impact and not fix1:isSensor() then ent2:impact(ent1, contact) end

    -- end, function (fix1, fix2, contact) -- endContact

    --     local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

    --     if not ent1 or not ent2 then return end -- this never happened ok?

    --     if ent1.impactEnd and not fix2:isSensor() then ent1:impactEnd(ent2, contact) end
    --     if ent2.impactEnd and not fix1:isSensor() then ent2:impactEnd(ent1, contact) end

    -- end --[[ preSolve ]] --[[ postSolve ]] )

--

function game.update(dt)

    if not game.map then return end

    if love.mouse.isDown("r") then dt = dt * 1.5 end


    if game.over then return end

    game.time = game.time + dt

    game.zoom = game.zoom + (game.zoomtarget - game.zoom) / 10
    game.camerax = game.camerax + ((0 - game.ship.body:getX()) * game.zoom - game.camerax) * dt * 10
    game.cameray = game.cameray + ((0 - game.ship.body:getY()) * game.zoom - game.cameray) * dt * 10
    game.mousex, game.mousey = utils.screenToWorld(love.mouse.getX(), love.mouse.getY())

    game.world:update(dt)
    for i,v in ipairs(game.afterWorldUpdate) do
        v()
    end
    for k,v in pairs(game.afterWorldUpdate) do game.afterWorldUpdate[k] = nil end

    game.map:update(dt)

    for k,v in pairs(game.particles) do
        v:update(dt)
    end

    for k,v in pairs(game.objects) do
        v:update(dt)
    end

end


function game.draw(dt)

    if not game.map then return end

    if game.over then

        love.graphics.setColor(210, 220, 250)

        love.graphics.setFont(fonts.droidsansbold[48])
        love.graphics.printf("GAME OVER", 0, love.graphics.getHeight() / 2 - 50, love.graphics.getWidth(), "center")

        love.graphics.setFont(fonts.droidsansbold[24])
        love.graphics.printf("You are dead", 0, love.graphics.getHeight() / 2 + 10, love.graphics.getWidth(), "center")

        love.graphics.printf("Score: " .. game.points, 0, love.graphics.getHeight() / 2 + 50, love.graphics.getWidth(), "center")

        return

    end

    love.graphics.setFont(fonts.droidsans[16])

    for k,v in pairs(game.background) do

        local x = game.camerax * v.parallax - v.x
        local y = game.cameray * v.parallax - v.y
        if x > 0 and y > 0 and x < love.window:getWidth() and y < love.window:getHeight() then

            love.graphics.setColor(v.r, v.g, v.b, v.parallax * 8000)
            love.graphics.point(x, y)

        end

    end


    love.graphics.push()
    love.graphics.translate(math.floor(game.camerax + love.window:getWidth() / 2) + .5, math.floor(game.cameray + love.window:getHeight()/2) + .5)
    love.graphics.scale(game.zoom)

        for k,v in pairs(game.particles) do
            love.graphics.setLineWidth(1)
            love.graphics.setColor(255, 255, 255)
            v:draw()
        end

        for k,v in pairs(game.objects) do
            love.graphics.setLineWidth(1)
            love.graphics.setColor(255, 255, 255)
            v:draw()
        end

        game.map:draw()

    love.graphics.pop()


    love.graphics.setColor(200, 230, 255, 200)
    love.graphics.print("Score: " .. game.points, 10, love.window.getHeight() - 25)

end
