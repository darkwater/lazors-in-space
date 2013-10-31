StaticDebris = class("StaticDebris", Entity)

---
-- StaticDebris:initialize
-- Creates an immobile polygon shape.
--
-- @param vertices  A table of vertices
--
function StaticDebris:initialize(...)
    local vertices = {...}

    -- Decide X/Y
    local xt,  yt    = {}, {}
    local odd        = true
    local sumx, sumy = 0, 0
    for k,v in pairs(vertices) do   table.insert(odd and xt or yt, v)  odd = not odd    end
    for k,v in pairs(xt) do         sumx = sumx + v                                     end
    for k,v in pairs(yt) do         sumy = sumy + v                                     end
    local x = sumx / #xt
    local y = sumy / #yt

    -- Fix vertices
    local odd = true
    for k,v in pairs(vertices) do   vertices[k] = v - (odd and x or y)  odd = not odd   end


    Entity.initialize(self, x, y, "static", love.physics.newPolygonShape(unpack(vertices)))

    self.editColor = { math.random(180,250), math.random(180,250), math.random(180,250) }
    self.grabbed = false
    self.rotating = false
end


---
-- StaticDebris:update
-- Updates the StaticDebris, used for the editor.
--
-- @param dt        Delta time
--
function StaticDebris:update(dt)
    if not editor.active then
        self.mouseover = false
        return
    end

    self.mouseover = editor.active and self.fixture:testPoint(editor.worldmousex, editor.worldmousey) and not ui.mouseover

    -- moving
    if self.mouseover and game.mousepressed["l"] then
        self.grabbed = true
        self.grabx = editor.worldmousex - self.body:getX()
        self.graby = editor.worldmousey - self.body:getY()
    elseif self.grabbed then
        self.body:setX(editor.worldmousex - self.grabx)
        self.body:setY(editor.worldmousey - self.graby)

        if game.mousereleased["l"] then
            self.grabbed = false
        end
    end

    -- rotating
    if self.mouseover and game.mousepressed["m"] then
        self.rotating = true
        local dx = editor.worldmousex - self.body:getX()
        local dy = editor.worldmousey - self.body:getY()

        self.rotateang = math.atan2(dy, dx) - self.body:getAngle()
    elseif self.rotating then
        local dx = editor.worldmousex - self.body:getX()
        local dy = editor.worldmousey - self.body:getY()

        self.body:setAngle((math.atan2(dy, dx) - self.rotateang) % (math.pi * 2))

        if game.mousereleased["m"] then
            self.rotating = false
        end
    end

    -- context menu
    if self.mouseover and game.mousepressed["r"] then
        self.menu = UIMenu:new()
        self.menu:addItem("Delete", function () self:destroy() end)
        self.menu:show(love.mouse.getX(), love.mouse.getY())
    elseif self.menu and game.mousereleased["r"] then
        self.menu:finish()
    end
end


---
-- StaticDebris:draw
-- Draws an outlined polygon.
--
function StaticDebris:draw()
    if self.mouseover then love.graphics.setColor(self.editColor)
                      else love.graphics.setColor(255, 255, 255) end

    love.graphics.polygon((self.mouseover and not self.grabbed and not self.rotatingA) and "fill" or "line", self.body:getWorldPoints(self.shape:getPoints()))
end
