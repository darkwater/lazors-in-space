CampaignMenu = class("CampaignMenu", Menu)

---
-- CampaignMenu:initialize
-- A menu showing the different campaigns available.
--
function CampaignMenu:initialize(x, y)

    Menu.initialize(self)


    local spacer = Spacer:new()
    self:addItem(spacer)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local exit = Button:new()
    exit.label = "Back"
    exit.submenu = MainMenu
    self:addItem(exit)

end
