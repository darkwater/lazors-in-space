Level = class("Level")

---
-- Level:initialize
-- A level on the sectormap
--
function Level:initialize(pack, sector, id, data)

    self.pack = pack
    self.sector = sector
    self.id = id
    self.data = data

    self.name = data.name
    self.position = { x = data.position[1], y = data.position[2] }

    self.hoverGlow = 0

end


---
-- Level:update
-- Called every frame.
--
-- @param dt        Time passed since last frame
-- @param mousex    Mouse X position on the translated starmap
-- @param mousey    Mouse Y position on the translated starmap
--
function Level:update(dt, mousex, mousey)

    local nowHovering = (mousex - self.position.x) ^ 2 + (mousey - self.position.y) ^ 2 < 10 ^ 2 * 2

    if nowHovering and not self.hovering then
        self:onMouseOver()
    end

    self.hovering = nowHovering

    if self.hovering then

        ui.cursor = "hand"

        if ui.buttonPressed["l"] then
            self:onActivate()
        end

        if self.hoverGlow < 1 then

            self.hoverGlow = math.min(1, self.hoverGlow + dt * 10)

        end

    elseif self.hoverGlow > 0 then

        self.hoverGlow = math.max(0, self.hoverGlow - dt * 9)

    end

end


---
-- Level:draw
-- Draws the menu.
--
function Level:draw()

    love.graphics.setFont(fonts.droidsans[24])

    love.graphics.push()
        love.graphics.translate(self.position.x, self.position.y)

        love.graphics.setColor(self.disabled and {140, 140, 140} or {250, 175 + self.hoverGlow * 75, self.hoverGlow * 250})
        love.graphics.line(0,-10, 0,10)
        love.graphics.line(-10,0, 10,0)

        love.graphics.print(self.name, 8, -28)

    love.graphics.pop()
    
end


---
-- Level:onMouseOver
-- Called when starting to hover over the Level.
--
function Level:onMouseOver()


    
end


---
-- Level:onActivate
-- Called when activated (eg. on click).
--
function Level:onActivate()

    game.load(self.pack, self.sector, self.id)
    menu.hide()
    
end
