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

    --== Game ==--
        game = {}
        game.time = 0
        game.world = love.physics.newWorld(0, 0, true)
        game.mousepressed = {}
        game.mousereleased = {}

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

        --== Background ==--
            game.background = {}

            for i = 1, 5000 do
                table.insert(game.background, {
                    parallax = math.random(1, 300) / 1000,
                    x = math.random(-3000, 3000),
                    y = math.random(-2000, 2000),
                    r = math.random(200, 255),
                    g = math.random(200, 255),
                    b = math.random(200, 255)
                })
            end
        --------------------

        game.ship = Ship:new(0, 0)
        game.map = Arena:new()

        game.world:setCallbacks( --[[ beginContact ]] function (fix1, fix2, contact)

            local ent1, ent2 = game.objects[(fix1:getUserData())], game.objects[(fix2:getUserData())]

            if not ent1 or not ent2 then return end -- this never happened ok?

            if ent1.impact then ent1:impact(ent2, contact) end
            if ent2.impact then ent2:impact(ent1, contact) end

        end --[[ endContact ]] --[[ preSolve ]] --[[ postSolve ]] )
    --------------

    --== Editor ==--
        editor = {}
        editor.active = false
    ----------------
end

function love.update(dt)
    game.time = game.time + dt
    if game.time - dt < math.floor(game.time) then
        love.window.setTitle(love.timer.getFPS())
    end

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
    for k,v in pairs(game.background) do
        local x = game.centerx * v.parallax - v.x
        local y = game.centery * v.parallax - v.y
        if x > 0 and y > 0 and x < love.window:getWidth() and y < love.window:getHeight() then
            love.graphics.setColor(v.r, v.g, v.b, v.parallax * 800)
            love.graphics.point(x, y)
        end
    end


    love.graphics.push()
    love.graphics.translate(math.floor(game.centerx) + .5, math.floor(game.centery) + .5)
        for k,v in pairs(game.particles) do
            love.graphics.setColor(255, 255, 255)
            v:draw()
        end

        for k,v in pairs(game.objects) do
            love.graphics.setColor(255, 255, 255)
            v:draw()
        end
    love.graphics.pop()


    --=# Editor #=--
    if editor.active then


    love.graphics.setColor(210, 220, 250)
    love.graphics.print("Editor mode", 10, 10)

    -- love.graphics.push()
    -- love.graphics.translate(math.floor(game.centerx) + .5, math.floor(game.centery) + .5)
    --     love.graphics.setColor(200, 240, 180)
    --     for _,obj in pairs(game.objects) do
    --         if obj.class.name == "StaticDebris" or obj.class.name == "MapBoundary" then
    --             local points = {obj.shape:getPoints()}
    --             for i=1, #points, 2 do
    --                 local dx = game.mousex - points[i]
    --                 local dy = game.mousey - points[i+1]
    --                 local dist = math.sqrt(dx^2 + dy^2)

    --                 local mousedown = dist < 10

    --                 love.graphics.circle(mousedown and "fill" or "line", points[i], points[i+1], 10, 12)
    --             end
    --         end
    --     end
    -- love.graphics.pop()

    end
    --=# Cleanup #=--

    for k,v in pairs(game.mousepressed) do
        game.mousepressed[k] = false
    end
    for k,v in pairs(game.mousereleased) do
        game.mousereleased[k] = false
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
        return
    end

    if key == "f10" then
        editor.active = not editor.active
    end
end

function love.mousepressed(x, y, but)
    game.mousepressed[but] = true
end
function love.mousereleased(x, y, but)
    game.mousereleased[but] = true
end
