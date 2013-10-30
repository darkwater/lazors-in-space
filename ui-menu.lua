UIMenu = class("UIMenu")

---
-- UIMenu:initialize
-- A generic context menu which can be used for several actions.
--
function UIMenu:initialize()
    self.items = {}
    self.visible = false
    self.selectedItem = 0

    self.width = 100
    self.height = 0
    self.paddingX = 8
    self.paddingY = 3

    self.id = ui.add(self)
end


---
-- UIMenu:addItem
-- Adds a new context menu entry.
--
-- @param label     The label to be shown in the menu
-- @param action    A function to execute when the entry is clicked
--
function UIMenu:addItem(label, action)
    table.insert(self.items, {
        label = label,
        action = action
    })
end


---
-- UIMenu:show
-- Shows the menu at a specified position.
--
-- @param x         X position
-- @param y         Y position
--
function UIMenu:show(x, y)
    self.x = x
    self.y = y
    self.visible = true
end


---
-- UIMenu:remove
-- Removes the menu.
--
function UIMenu:remove()
    self.visible = false
    ui.remove(self.id)
    self = nil
end


---
-- UIMenu:finish
-- Executes the selected item (if any) and removes the menu.
--
function UIMenu:finish()
    if self.selectedItem > 0 then
        self.items[self.selectedItem].action()
    end

    self:remove(self.id)
end


---
-- UIMenu:update
-- Handles item clicks etc.
--
-- @param dt        Time passed since last frame
--
function UIMenu:update(dt)
    if not self.visible then return end

    local mx, my = love.mouse.getX(), love.mouse.getY()

    if mx > self.x and my > self.y and mx < self.x + self.width and my < self.y + self.height then
        self.selectedItem = math.ceil((my - self.y) / 20)
        return true
    else
        self.selectedItem = 0
    end
end


---
-- UIMenu:draw
-- Draws the context menu.
--
function UIMenu:draw()
    if not self.visible then return end

    love.graphics.setColor(29, 31, 33)
    love.graphics.rectangle("fill", self.x, self.y, self.width, #self.items * 20 + self.paddingY * 2)


    love.graphics.setFont(fonts.droidsansbold[14])

    local y = self.y + self.paddingY
    for k,v in pairs(self.items) do
        if self.selectedItem == k then
            love.graphics.setColor(50, 52, 54)
            love.graphics.rectangle("fill", self.x, y, self.width, 20)
        end

        love.graphics.setColor(220, 220, 220)
        love.graphics.print(v.label, self.x + self.paddingX, y + 2)
        y = y + 20
    end
    self.height = y
end
