Button = class("Button")

---
-- Button:initialize
-- A button item in a menu.
--
function Button:initialize()

    self.label = "Do nothing"

    self.x = ui.width / 2
    self.y = 150
    self.width = ui.width - 200
    self.height = 70

    self.hovering = false
    self.hoverBump = 0

end


---
-- Button:update
-- Called every frame.
--
-- @param dt        Time passed since last frame
--
function Button:update(dt)

    if self.hoverBump > dt * 3 then
        self.hoverBump = self.hoverBump - dt * 3
    else
        self.hoverBump = 0
    end


    local nowHovering = ui.mousey > self.y and ui.mousey <= self.y + self.height

    if nowHovering and not self.hovering then
        self:onMouseOver()
    end

    self.hovering = nowHovering

    if self.hovering and ui.buttonPressed["l"] then
        self:onActivate()
    end

end


---
-- Button:draw
-- Draws the menu.
--
function Button:draw()

    love.graphics.setColor(self.hovering and {250, 250, 250} or {255, 175, 0})
    love.graphics.setFont(fonts.dejavusansextralight[36])

    love.graphics.push()
        love.graphics.translate(self.x, self.y  + self.height / 2)
        love.graphics.scale(1 + self.hoverBump * 0.2)
        love.graphics.printf(self.label, -self.width / 2, -23, self.width, "center")
    love.graphics.pop()
    
end


---
-- Button:onMouseOver
-- Called when starting to hover over the button.
--
function Button:onMouseOver()

    self.hoverBump = 1
    
end


---
-- Button:onActivate
-- Called when activated (eg. on click).
--
function Button:onActivate()

    print(self.label + " activated!")
    
end
