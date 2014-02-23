Header = class("Header")

---
-- Header:initialize
-- A blank Header with variable height.
--
function Header:initialize()

    self.label = "Untitled"
    self.height = 90

end


---
-- Header:update
-- Called every frame, does nothing.
--
-- @param dt        Time passed since last frame
--
function Header:update(dt)

end


---
-- Header:draw
-- Draws the LiS logo.
--
function Header:draw()

    love.graphics.setColor(255, 175, 0)
    love.graphics.setFont(fonts.dejavusansextralight[48])

    love.graphics.printf(self.label, 0, self.y  + self.height / 2 - 23, ui.width, "center")
    
end
