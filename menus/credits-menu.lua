CreditsMenu = class("CreditsMenu", Menu)

---
-- CreditsMenu:initialize
-- A menu showing the different campaigns available.
--
function CreditsMenu:initialize()

    Menu.initialize(self)


    local header = Header:new()
    header.label = "Credits"
    self:addItem(header)

    local spacer = Spacer:new()
    spacer.height = 20
    self:addItem(spacer)

    local credits = {
        {"Lead Programmer", {
            "Sam Lakerveld"
        }},
        {"Notes", {
            "I'm currently the only developer",
            "working on this, and this screen exists",
            "mainly to make the main menu look less",
            "empty. You should contribute to this game",
            "and have your name appear here!"
        }}
    }

    for k,v in pairs(credits) do

        local func = Text:new()
        func.value = v[1]
        func.bold = true
        self:addItem(func)

        for _,v2 in pairs(v[2]) do

            local name = Text:new()
            name.value = v2
            self:addItem(name)

        end

        local spacer = Spacer:new()
        spacer.height = 20
        self:addItem(spacer)

    end

    local spacer = Spacer:new()
    self:addItem(spacer)

    local back = Button:new()
    back.label = "Back"
    back.submenu = MainMenu
    self:addItem(back)

end
