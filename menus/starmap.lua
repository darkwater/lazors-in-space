Starmap = class("Starmap")

---
-- Starmap:initialize
-- A screen showing the different sectors available.
--
function Starmap:initialize()

    self.buttons = {}

    -- local more = Button:new()
    -- more.label = "Online map"
    -- more.width = 300
    -- more.x = ui.width - more.width
    -- more.y = ui.height - more.height * 2
    -- more.submenu = MainMenu
    -- table.insert(self.buttons, more)

    local back = Button:new()
    back.label = "Back"
    back.width = 150
    back.x = ui.width - back.width
    back.y = ui.height - back.height
    back.submenu = MainMenu
    table.insert(self.buttons, back)


    self.camera = {0, 0}


    self.sectors = {}

    for _,dirname in pairs(love.filesystem.getDirectoryItems("content")) do

        local str = love.filesystem.read("content/" .. dirname .. "/info.json")
        local info = json.decode(str)

        for _,sector in pairs(info.sectors) do
            
            table.insert(self.sectors, Sector:new(sector))

        end

    end

end


---
-- Starmap:update
-- Updates the starmap
--
function Starmap:update(dt)

    for k,v in pairs(self.sectors) do

        v:update(dt, ui.mousex - (math.floor(self.camera[1] + ui.width / 2) + .5), ui.mousey - (math.floor(self.camera[2] + ui.height / 2) + .5))

    end


    for k,v in pairs(self.buttons) do

        v:update(dt)

    end

end


---
-- Starmap:draw
-- Draws the starmap
--
function Starmap:draw()

    love.graphics.push()
        love.graphics.translate(math.floor(self.camera[1] + ui.width / 2) + .5, math.floor(self.camera[2] + ui.height / 2) + .5)

        for k,v in pairs(self.sectors) do

            v:draw()

        end

    love.graphics.pop()


    for k,v in pairs(self.buttons) do

        v:draw()

    end

end
