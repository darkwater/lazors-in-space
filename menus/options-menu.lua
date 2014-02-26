OptionsMenu = class("OptionsMenu", Menu)

---
-- OptionsMenu:initialize
-- A menu showing the different campaigns available.
--
function OptionsMenu:initialize()

    Menu.initialize(self)


    local header = Header:new()
    header.label = "Options"
    self:addItem(header)

    local spacer = Spacer:new()
    spacer.height = 20
    self:addItem(spacer)

    local text = Text:new()
    text.value = "Not much to do here yet"
    self:addItem(text)

    local spacer = Spacer:new()
    self:addItem(spacer)

    local back = Button:new()
    back.label = "Back"
    back.submenu = MainMenu
    self:addItem(back)

end
