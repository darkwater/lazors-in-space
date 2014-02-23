Title = class("Title")

---
-- Title:initialize
-- A blank Title with variable height.
--
function Title:initialize()

    self.height = 200

end


---
-- Title:update
-- Called every frame, does nothing.
--
-- @param dt        Time passed since last frame
--
function Title:update(dt)

end


---
-- Title:draw
-- Draws the LiS logo.
--
function Title:draw()

    love.graphics.push()
        love.graphics.translate(ui.width / 2 - 100.5, self.y - .5)
        love.graphics.setColor(255, 255, 255)
        love.graphics.setLineWidth(1)

        -- 200 x 160
        love.graphics.line(  0,0,  40,0,  40,120,  80,120,  80,160,  0,160,  0,0                                                      ) -- L
        love.graphics.line( 60,0,  80,0,  80,100,  60,100,  60,0                                                                      ) -- I
        love.graphics.line(100,0, 200,0, 200,40,  140,40,  140,60, 200,60, 200,160, 100,160, 100,120, 160,120, 160,100, 100,100, 100,0) -- S

    love.graphics.pop()
    
end
