Menu = class("Menu")

---
-- Menu:initialize
-- The base class for every Menu. Override this in a menu.
--
function Menu:initialize()

    self.items = {}

    self.nexty = 120

end


---
-- Menu:addItem
-- Adds an item to the menu.
--
-- @param item      An item object to add, usually derived from a Button
--
function Menu:addItem(item)

    item.y = self.nexty
    table.insert(self.items, item)

    self.nexty = self.nexty + item.height

end


---
-- Menu:update
-- Handles input and stuff.
--
-- @param dt        Time passed since last frame
--
function Menu:update(dt)

    for k,v in pairs(self.items) do

        v:update(dt)

    end

end


---
-- Menu:draw
-- Draws the menu.
--
function Menu:draw()

    for k,v in pairs(self.items) do

        v:draw()

    end
    
end
