Spacer = class("Spacer")

---
-- Spacer:initialize
-- A blank spacer with variable height.
--
function Spacer:initialize()

    self.x = ui.width / 2
    self.y = 150
    self.width = ui.width - 200
    self.height = 50

end


---
-- Spacer:update
-- Called every frame, does nothing.
--
-- @param dt        Time passed since last frame
--
function Spacer:update(dt)

end


---
-- Spacer:draw
-- Draws nothing.
--
function Spacer:draw()
    
end
