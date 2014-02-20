MainMenu = class("MainMenu", Menu)

---
-- MainMenu:initialize
-- The main menu, presented at startup.
--
function MainMenu:initialize(x, y)

    Menu.initialize(self)

    local test = Button:new()
    test.label = "Hello world"

    self:addItem(test)

end
