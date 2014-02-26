MainMenu = class("MainMenu", Menu)

---
-- MainMenu:initialize
-- The main menu, presented at startup.
--
function MainMenu:initialize()

    Menu.initialize(self)


    local title = Title:new()
    self:addItem(title)

    local play = Button:new()
    play.label = "Play"
    play.submenu = Starmap
    self:addItem(play)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local options = Button:new()
    options.label = "Options"
    options.submenu = OptionsMenu
    self:addItem(options)

    local credits = Button:new()
    credits.label = "Credits"
    credits.submenu = CreditsMenu
    self:addItem(credits)

    local exit = Button:new()
    exit.label = "Exit"
    exit.callback = function(self)
        love.event.quit()
    end
    self:addItem(exit)

end
