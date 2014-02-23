PlayMenu = class("PlayMenu", Menu)

---
-- PlayMenu:initialize
-- A menu showing the different campaigns available.
--
function PlayMenu:initialize(x, y)

    Menu.initialize(self)


    local header = Header:new()
    header.label = "Pick a campaign"
    self:addItem(header)

    local packSelect = Button:new()
    packSelect.label = "Alpha Sector"
    packSelect.submenu = MainMenu
    self:addItem(packSelect)

    local packSelect = Button:new()
    packSelect.label = "Beta Sector"
    packSelect.submenu = MainMenu
    packSelect.disabled = true
    self:addItem(packSelect)

    local packSelect = Button:new()
    packSelect.label = "Gamma Sector"
    packSelect.submenu = MainMenu
    packSelect.disabled = true
    self:addItem(packSelect)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local exit = Button:new()
    exit.label = "Back"
    exit.submenu = MainMenu
    self:addItem(exit)

end
