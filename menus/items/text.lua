Text = class("Text")

---
-- Text:initialize
-- A blank Text with variable height.
--
function Text:initialize()

    self.value = "- No text -"
    self.height = 30
    self.bold = false

end


---
-- Text:update
-- Called every frame, does nothing.
--
-- @param dt        Time passed since last frame
--
function Text:update(dt)

end


---
-- Text:draw
-- Draws the LiS logo.
--
function Text:draw()

    love.graphics.setColor(255, 175, 0)
    love.graphics.setFont(self.bold and fonts.droidsansbold[24] or fonts.droidsans[24])

    love.graphics.printf(self.value, 0, self.y + self.height / 2 - 23, ui.width, "center")
    
end
