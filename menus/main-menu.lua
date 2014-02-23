MainMenu = class("MainMenu", Menu)

---
-- MainMenu:initialize
-- The main menu, presented at startup.
--
function MainMenu:initialize(x, y)

    Menu.initialize(self)


    local title = Title:new()
    self:addItem(title)

    local play = Button:new()
    play.label = "Play"
    play.submenu = PlayMenu
    self:addItem(play)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local options = Button:new()
    options.label = "Options"
    self:addItem(options)

    local about = Button:new()
    about.label = "About"
    self:addItem(about)

    local exit = Button:new()
    exit.label = "Exit"
    exit.callback = function(self)
        love.event.quit()
    end
    self:addItem(exit)

end
