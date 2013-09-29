function love.load()
    love.physics.setMeter(64)

    class = require("middleclass")
    require("constants")
    require("entity")
    require("map-boundary")
    require("circle-entity")
    require("static-debris")
    require("bullet-impact")
    require("bullet")
    require("map")
    require("maps.main-menu")
    require("ship")

    game = {}
    game.world = love.physics.newWorld(0, 0, true)

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
    
    game.ship = Ship:new(100, 100)
    game.map = MainMenu:new()

    game.world:setCallbacks( --[[ beginContact ]] function (fix1, fix2, contact)

        local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]
        local bullet = false

        if     ent1 and ent1.isBullet then ent1:destroy()  bullet = 1
        elseif ent2 and ent2.isBullet then ent2:destroy()  bullet = 2 end

        if bullet then
            local x, y = contact:getPositions()

            BulletImpact:new(x, y)
        end

    end --[[ endContact ]] --[[ preSolve ]] --[[ postSolve ]] )
end

function love.update(dt)
    game.world:update(dt)

    -- game.map:update()

    for k,v in pairs(game.particles) do
        v:update(dt)
    end

    for k,v in pairs(game.objects) do
        v:update(dt)
    end
end

function love.draw()
    game.ship:draw()

    for k,v in pairs(game.particles) do
        v:draw()
    end

    for k,v in pairs(game.objects) do
        v:draw()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
