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
    require("shield")
    require("base-ai")
    require("map")
    require("maps.arena")
    require("ship")

    game = {}
    game.world = love.physics.newWorld(0, 0, true)

    game.centerx = 0
    game.centery = 0

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
    
    game.ship = Ship:new(0, 0)
    game.map = Arena:new()

    game.world:setCallbacks( --[[ beginContact ]] function (fix1, fix2, contact)

        local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]
        
        if not ent1 or not ent2 then return end -- this never happened ok?

        if ent1.impact then ent1:impact(ent2, contact) end
        if ent2.impact then ent2:impact(ent1, contact) end

    end --[[ endContact ]] --[[ preSolve ]] --[[ postSolve ]] )
end

function love.update(dt)
    game.centerx = game.centerx + (love.window:getWidth() /2 - game.ship.body:getX() - game.centerx) / 10
    game.centery = game.centery + (love.window:getHeight()/2 - game.ship.body:getY() - game.centery) / 10
    game.mousex  = love.mouse.getX() - game.centerx
    game.mousey  = love.mouse.getY() - game.centery

    game.world:update(dt)
    game.map:update(dt)

    -- game.map:update()

    for k,v in pairs(game.particles) do
        v:update(dt)
    end

    for k,v in pairs(game.objects) do
        v:update(dt)
    end
end

function love.draw()
    love.graphics.translate(game.centerx, game.centery)

    for k,v in pairs(game.particles) do
        love.graphics.setColor(255, 255, 255)
        v:draw()
    end

    for k,v in pairs(game.objects) do
        love.graphics.setColor(255, 255, 255)
        v:draw()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
