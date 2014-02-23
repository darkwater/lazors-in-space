MainMenu = class("MainMenu", Menu)

---
-- MainMenu:initialize
-- The main menu, presented at startup.
--
function MainMenu:initialize(x, y)

    Menu.initialize(self)


    local campaign = Button:new()
    campaign.label = "Play Campaign"
    campaign.submenu = CampaignMenu
    self:addItem(campaign)

    local customlevels = Button:new()
    customlevels.label = "Custom Levels"
    customlevels.submenu = CustomLevelsMenu
    self:addItem(customlevels)

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
