Sector = class("Sector")

---
-- Sector:initialize
-- A sector on the starmap
--
function Sector:initialize(data)

    self.name = data.name
    self.center = data.center
    self.boundary = {}

    self.minx, self.maxx = 0, 0
    self.miny, self.maxy = 0, 0

    for k,v in pairs(data.boundary) do

        table.insert(self.boundary, v[1])
        table.insert(self.boundary, v[2])

        self.minx = math.min(v[1], self.minx)
        self.maxx = math.max(v[1], self.maxx)

        self.miny = math.min(v[2], self.miny)
        self.maxy = math.max(v[2], self.maxy)

    end

    self.width = self.maxx - self.minx
    self.height = self.maxy - self.miny

end


---
-- Sector:update
-- Called every frame.
--
-- @param dt        Time passed since last frame
-- @param mousex    Mouse X position on the translated starmap
-- @param mousey    Mouse Y position on the translated starmap
--
function Sector:update(dt, mousex, mousey)

    local nowHovering = util.pointInRectangle(self.minx, self.miny, self.width, self.height, mousex - self.center[1], mousey - self.center[2])
                    and util.pointInPolygon(self.boundary, mousex - self.center[1], mousey - self.center[2])

    if nowHovering and not self.hovering then
        self:onMouseOver()
    end

    self.hovering = nowHovering

    if self.hovering then

        ui.cursor = "hand"

        if ui.buttonPressed["l"] then
            self:onActivate()
        end

    end

end


---
-- Sector:draw
-- Draws the menu.
--
function Sector:draw()

    love.graphics.setColor(self.disabled and {140, 140, 140} or self.hovering and {250, 250, 250} or {255, 175, 0})
    love.graphics.setFont(fonts.droidsans[24])

    love.graphics.push()
        love.graphics.translate(unpack(self.center))

        love.graphics.polygon("line", self.boundary)

        love.graphics.printf(self.name, -self.width / 2, -23, self.width, "center")

    love.graphics.pop()
    
end


---
-- Sector:onMouseOver
-- Called when starting to hover over the sector.
--
function Sector:onMouseOver()


    
end


---
-- Sector:onActivate
-- Called when activated (eg. on click).
--
function Sector:onActivate()

    print("Loading " .. self.name)
    
end
