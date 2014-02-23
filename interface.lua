--== Fonts ==--

    fonts = {}
    fonts.droidsans = {}
    fonts.droidsans[14] = love.graphics.newFont("fonts/DroidSans.ttf", 14)
    fonts.droidsans[16] = love.graphics.newFont("fonts/DroidSans.ttf", 16)
    fonts.droidsans[24] = love.graphics.newFont("fonts/DroidSans.ttf", 24)
    fonts.droidsans[36] = love.graphics.newFont("fonts/DroidSans.ttf", 36)
    fonts.droidsans[48] = love.graphics.newFont("fonts/DroidSans.ttf", 48)
    fonts.droidsansbold = {}
    fonts.droidsansbold[14] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 14)
    fonts.droidsansbold[24] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 24)
    fonts.droidsansbold[48] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 48)
    fonts.dejavusansextralight = {}
    fonts.dejavusansextralight[14] = love.graphics.newFont("fonts/DejaVuSans-ExtraLight.ttf", 14)
    fonts.dejavusansextralight[24] = love.graphics.newFont("fonts/DejaVuSans-ExtraLight.ttf", 24)
    fonts.dejavusansextralight[36] = love.graphics.newFont("fonts/DejaVuSans-ExtraLight.ttf", 36)
    fonts.dejavusansextralight[42] = love.graphics.newFont("fonts/DejaVuSans-ExtraLight.ttf", 42)
    fonts.dejavusansextralight[48] = love.graphics.newFont("fonts/DejaVuSans-ExtraLight.ttf", 48)

---------------

--== Sounds ==--

    local soundsToLoad = { {"player_shoot", "ogg", "static"}, {"enemy_hit", "ogg", "static"}, {"bullet_hit", "ogg", "static"}, {"player_hit", "ogg", "static"} }
    sounds = {}

    for k,v in pairs(soundsToLoad) do
        sounds[v[1]] = love.audio.newSource("sounds/"..v[1].."."..v[2], v[3])
    end

    function sounds.play(name)

        sounds[name]:rewind()
        sounds[name]:play()

    end

----------------

--== General ==--

    ui = {}

    ui.mousex = 0
    ui.mousey = 0

    ui.width = love.window.getWidth()
    ui.height = love.window.getHeight()

    ui.buttonPressed = {}
    ui.buttonReleased = {}

-----------------

--== Background ==--

    ui.background = {}

    for i = 1, 2000 do

        table.insert(ui.background,
        {
            x = math.random(0, 1000) / 1000,
            y = math.random(0, 1000) / 1000,
            r = math.random(220, 255),
            g = math.random(220, 255),
            b = math.random(220, 255),
            a = math.random(50, 100)
        })

    end

    for i = 1, 50 do

        table.insert(ui.background,
        {
            x = math.random(0, 1000) / 1000,
            y = math.random(0, 1000) / 1000,
            r = math.random(230, 255),
            g = math.random(230, 255),
            b = math.random(230, 255),
            a = math.random(150, 200)
        })

    end

--------------------

--== Cursor ==--

    ui.cursors = {}

    for k,v in pairs({"arrow", "ibeam", "wait", "hand"}) do

        ui.cursors[v] = love.mouse.getSystemCursor(v)

    end

    ui.currentCursor = "arrow"
    ui.nextCursor = "arrow" -- Set in update loop
    love.mouse.setCursor(ui.cursors["arrow"])

    ui.setCursor = function (new)

        if not ui.cursors[new] or ui.currentCursor == new then return false end

        love.mouse.setCursor(ui.cursors[new])
        ui.currentCursor = new
        return true

    end

----------------

--== Menu ==--

    menu = {}
    menu.menu = MainMenu:new()
    menu.menuCanvas = love.graphics.newCanvas(ui.width, ui.height)
    menu.menuTransition = 0
    menu.oldMenuCanvas = nil

    function menu.update(dt)

        for k,v in pairs(ui.background) do

            v.x = (v.x - dt / 500) % 1

        end

        if not menu.menu then return end

        ui.nextCursor = "arrow"


        menu.menu:update(dt)

        if menu.menuTransition > 0 then
            menu.menuTransition = menu.menuTransition - dt * 3
        end
        if menu.menuTransition < 0 then
            menu.menuTransition = 0
        end


        ui.setCursor(ui.nextCursor)

    end


    function menu.draw()

        love.graphics.setPointSize(1)
        for k,v in pairs(ui.background) do

            love.graphics.setColor(v.r, v.g, v.b, v.a + math.sin(v.r + time * 4) * 30)
            love.graphics.point(math.floor(v.x * love.window.getWidth()), math.floor(v.y * love.window.getHeight()))

        end

        if not menu.menu then return end -- don't have to draw anything else anyway


        menu.menuCanvas:clear()
        love.graphics.setCanvas(menu.menuCanvas)
            menu.menu:draw()
        love.graphics.setCanvas()

        love.graphics.push()
            love.graphics.translate(ui.width / 2, ui.height / 2)
            love.graphics.scale(1 + menu.menuTransition * 0.4)

            love.graphics.setColor(255, 255, 255, 255 - 255 * menu.menuTransition)
            love.graphics.draw(menu.menuCanvas, 0, 0, 0, 1, 1, ui.width / 2, ui.height / 2)
        love.graphics.pop()


        if menu.menuTransition > 0 then

            love.graphics.push()
                love.graphics.translate(ui.width / 2, ui.height / 2)
                love.graphics.scale(menu.menuTransition * 0.3 + 0.7)

                love.graphics.setColor(255, 255, 255, 255 * menu.menuTransition)
                love.graphics.draw(menu.oldMenuCanvas, 0, 0, 0, 1, 1, ui.width / 2, ui.height / 2)
            love.graphics.pop()

        end

    end


    function menu.load(new)

        menu.oldMenuCanvas = menu.menuCanvas
        menu.menuCanvas = love.graphics.newCanvas(ui.width, ui.height)
        menu.menuTransition = 1

        menu.menu = new:new()

    end

-----------------
