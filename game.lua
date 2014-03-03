--== General ==--

    game = {}
    game.time = 0
    game.over = false
    game.paused = true
    game.world = love.physics.newWorld(0, 0, true)
    ui.buttonPressed = {}
    ui.buttonReleased = {}
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

function game.load(pack, sector, level)

    local str = love.filesystem.read("content/" .. pack .. "/info.json")
    local info = json.decode(str)
    local level = info.sectors[sector].levels[level]

    game.map = Map:new()
    game.map:loadMap(pack, level.map, level.lua)

    game.ship = Ship:new(0, 0)

    game.world:setCallbacks(function (fix1, fix2, contact) -- beginContact

        local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

        if not ent1 or not ent2 then return end -- this never happened ok?

        if ent1.impact and not fix2:isSensor() then ent1:impact(ent2, contact) end
        if ent2.impact and not fix1:isSensor() then ent2:impact(ent1, contact) end

    end, function (fix1, fix2, contact) -- endContact

        local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

        if not ent1 or not ent2 then return end -- this never happened ok?

        if ent1.impactEnd and not fix2:isSensor() then ent1:impactEnd(ent2, contact) end
        if ent2.impactEnd and not fix1:isSensor() then ent2:impactEnd(ent1, contact) end

    end --[[ preSolve ]] --[[ postSolve ]] )

end


function game.update(dt)

    if not game.map then return end

    if love.mouse.isDown("r") then dt = dt * 1.5 end


    if game.over then return end

    game.time = game.time + dt

    game.zoom = game.zoom + (game.zoomtarget - game.zoom) / 10
    game.camerax = game.camerax + ((0 - game.ship.body:getX()) * game.zoom - game.camerax) * dt * 10
    game.cameray = game.cameray + ((0 - game.ship.body:getY()) * game.zoom - game.cameray) * dt * 10
    game.mousex, game.mousey = util.screenToWorld(love.mouse.getX(), love.mouse.getY())

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
