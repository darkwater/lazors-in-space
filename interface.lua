--== Fonts ==--

    fonts = {}
    fonts.droidsans = {}
    fonts.droidsans[14] = love.graphics.newFont("fonts/DroidSans.ttf", 14)
    fonts.droidsans[16] = love.graphics.newFont("fonts/DroidSans.ttf", 16)
    fonts.droidsans[24] = love.graphics.newFont("fonts/DroidSans.ttf", 24)
    fonts.droidsansbold = {}
    fonts.droidsansbold[14] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 14)
    fonts.droidsansbold[24] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 24)
    fonts.droidsansbold[48] = love.graphics.newFont("fonts/DroidSans-Bold.ttf", 48)

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

--== Background ==--

    background = {}

    for i = 1, 3000 do

        table.insert(background,
        {
            x = math.random(0, 1000) / 1000,
            y = math.random(0, 1000) / 1000,
            r = math.random(200, 255),
            g = math.random(200, 255),
            b = math.random(200, 255),
            a = math.random(10, 180)
        })

    end

--------------------

--== Menu ==--

    menu = {}
    menu.menu = MainMenu:new()

    function menu.update(dt)

        if not menu.menu then return end

        menu.menu:update(dt)

    end


    function menu.draw()

        for k,v in pairs(background) do

            love.graphics.setColor(v.r, v.g, v.b, v.a)
            love.graphics.point(v.x * love.window.getWidth(), v.y * love.window.getHeight())

        end

        if not menu.menu then return end

        menu.menu:draw()

    end

-----------------
