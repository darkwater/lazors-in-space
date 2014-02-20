Button = class("Button")

---
-- Button:initialize
-- A button item in a menu.
--
function Button:initialize()

    self.label = "Do nothing"

    self.x = 100
    self.y = 150
    self.width = love.window.getWidth() - 200

end


---
-- Button:update
-- Called every frame.
--
-- @param dt        Time passed since last frame
--
function Button:update(dt)


    
end


---
-- Button:draw
-- Draws the menu.
--
function Button:draw()

    love.graphics.setColor(255, 175, 0)
    love.graphics.setFont(fonts.droidsans[24])
    love.graphics.printf(self.label, self.x, self.y, self.width, "center")
    
end
