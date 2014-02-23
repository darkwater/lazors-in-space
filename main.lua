math.randomseed(os.time())

function love.load()
    love.physics.setMeter(64)

    class = require("middleclass")
    require("json")
    require("constants")
    require("utils")
    require("event")

    require("menu")

    for k,v in pairs(love.filesystem.getDirectoryItems("menus")) do

        if love.filesystem.isFile("menus/" .. v) then

            require("menus/" .. v:gsub(".lua", ""))

        end

    end

    for k,v in pairs(love.filesystem.getDirectoryItems("menus/items")) do

        if love.filesystem.isFile("menus/items/" .. v) then

            require("menus/items/" .. v:gsub(".lua", ""))

        end

    end

    require("entity")
    require("circle-entity")
    require("static-debris")
    require("trigger")
    require("bullet-impact")
    require("bullet")
    require("shield")
    require("base-ai")
    require("pont")
    require("bute")
    require("entity-spawner")
    require("map")
    require("ship")

    require("interface")
    require("game")

    love.graphics.setLineWidth(1.1)

    time = 0

end


function love.update(dt)

    time = time + dt

    ui.mousex = love.mouse.getX()
    ui.mousey = love.mouse.getY()

    menu.update(dt)

    game.update(dt)

end


function love.draw()

    menu.draw()

    game.draw()


    --=# Cleanup #=--

    for k,v in pairs(ui.buttonPressed) do
        ui.buttonPressed[k] = false
    end

    for k,v in pairs(ui.buttonReleased) do
        ui.buttonReleased[k] = false
    end


    love.graphics.setColor(210, 220, 250, 180)
    love.graphics.setFont(fonts.droidsansbold[14])
    love.graphics.print(love.timer.getFPS(), 0, 0)

end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
        return
    end
end


function love.mousepressed(x, y, but)
    ui.buttonPressed[but] = true

    -- Zoom is broken; don't use it
    -- if but == "wu" then
    --     game.zoomtarget = game.zoomtarget * 1.05
    -- elseif but == "wd" then
    --     game.zoomtarget = game.zoomtarget * 0.95
    -- end
end


function love.mousereleased(x, y, but)
    ui.buttonReleased[but] = true
end


function love.resize(w, h)
    ui.width = w
    ui.height = h
    
    menu.menuCanvas = love.graphics.newCanvas(w, h)
end
