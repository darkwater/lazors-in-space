Entity = class("Entity")

---
-- Entity:initialize
-- The base class for every entity.
--
-- @param x         X position
-- @param y         Y position
-- @param bodyType  "statis", "dynamic" or "kinematic"
-- @param shape     Shape, using love.physics.new*Shape()
--
function Entity:initialize(x, y, bodyType, shape)
    self.x        = x
    self.y        = y
    self.objectid = game.addObject(self)
    self.body     = love.physics.newBody(game.world, self.x, self.y, bodyType)
    self.shape    = shape
    self.fixture  = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(0.1)
    self.fixture:setUserData(self.objectid)
end


---
-- Entity:update
-- Does nothing by default, override this in a subclass.
--
function Entity:update()
    
end


---
-- Entity:draw
-- Does nothing by default, override this in a subclass.
--
function Entity:draw()
    
end


---
-- Entity:impact
-- Gets called whenever there's a collision with another entity.
--
-- @param ent       The entity collided with
-- @param contact   The contact object of the collision
--
function Entity:impact(ent, contact)

end


---
-- Entity:destroy
-- Destroys the entity.
--
function Entity:destroy()
    self.body:destroy()
    game.objects[self.objectid] = nil
    self = nil
end
