--== Fonts ==--

    fonts = {}
    fonts.droidsans = {}
    fonts.droidsans[14] = love.graphics.newFont("fonts/DroidSans.ttf", 14)
    fonts.droidsans[16] = love.graphics.newFont("fonts/DroidSans.ttf", 16)
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

--== Menu ==--

    menu = {}
    menu.menu = Menu:new()

    function menu.update(dt)

        if not menu.menu then return end

        menu.menu:update(dt)

    end


    function menu.draw()

        if not menu.menu then return end

        menu.menu:draw()

    end

-----------------
