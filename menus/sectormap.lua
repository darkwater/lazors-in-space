Sectormap = class("Sectormap")

---
-- Sectormap:initialize
-- A screen showing the different levels available in a sector.
--
function Sectormap:initialize(pack, id)

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
    back.submenu = Starmap
    table.insert(self.buttons, back)


    self.camera = {0, 0}


    self.levels = {}

    local str = love.filesystem.read("content/" .. pack .. "/info.json")
    local info = json.decode(str)

    for k,level in pairs(info.sectors[id].levels) do

        table.insert(self.levels, Level:new(pack, id, k, level))

    end

end


---
-- Sectormap:update
-- Updates the Sectormap
--
function Sectormap:update(dt)

    for k,v in pairs(self.levels) do

        v:update(dt, ui.mousex - (math.floor(self.camera[1] + ui.width / 2) + .5), ui.mousey - (math.floor(self.camera[2] + ui.height / 2) + .5))

    end


    for k,v in pairs(self.buttons) do

        v:update(dt)

    end

end


---
-- Sectormap:draw
-- Draws the Sectormap
--
function Sectormap:draw()

    love.graphics.push()
        love.graphics.translate(math.floor(self.camera[1] + ui.width / 2) + .5, math.floor(self.camera[2] + ui.height / 2) + .5)

        for k,v in pairs(self.levels) do

            v:draw()

        end

    love.graphics.pop()


    for k,v in pairs(self.buttons) do

        v:draw()

    end

end
