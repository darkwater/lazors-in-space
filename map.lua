Map = class("Map")

---
-- Map:initialize
-- The base class for every map.
--
-- @returns nil     Nothing
function Map:initialize()
    StaticDebris:new({50,200 , 300,300 , 290,330 , 100,250})
    MapBoundary:new({10,10 , 914,10 , 914,100 , 964,100 , 964,10 , 1014,10 , 1014,566 , 10,566})
end


---
-- Map:update
-- Does nothing by default, override this in a subclass.
--
-- @returns nil     Nothing
function Map:update()
    
end
