function love.load()
    love.physics.setMeter(64)

    class = require("middleclass")
    require("constants")
    require("entity")
    require("map-boundary")
    require("circle-entity")
    require("static-debris")
    require("bullet")
    require("map")
    require("maps.main-menu")
    require("ship")

    game = {}
    game.world = love.physics.newWorld(0, 0, true)

    game.objects = {}
    game.nextObjId = 1

    game.addObject = function (obj)
        local id = game.nextObjId
        game.nextObjId = game.nextObjId + 1
        game.objects[id] = obj
        return id - 1
    end
    
    game.ship = Ship:new(100, 100)
    game.map = MainMenu:new()

    game.world:setCallbacks( --[[ beginContact ]] function (fix1, fix2, contact)

        local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

        if ent1 and ent1.isBullet then ent1:destroy() end
        if ent2 and ent2.isBullet then ent2:destroy() end

    end --[[ endContact ]] --[[ preSolve ]] --[[ postSolve ]] )
end

function love.update(dt)
    game.world:update(dt)

    game.map:update()

    for k,v in pairs(game.objects) do
        v:update()
    end
end

function love.draw()
    game.ship:draw()

    for k,v in pairs(game.objects) do
        v:draw()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
