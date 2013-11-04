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

end


---
-- StaticDebris:draw
-- Draws an outlined polygon.
--
function StaticDebris:draw()
    love.graphics.polygon((self.mouseover and not self.grabbed and not self.rotatingA) and "fill" or "line", self.body:getWorldPoints(self.shape:getPoints()))
end
