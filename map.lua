Map = class("Map")

---
-- Map:initialize
-- The base class for every map.
--
-- @returns nil     Nothing
function Map:initialize()
    
end


---
-- Map:update
-- Does nothing by default, override this in a subclass.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function Map:update()
    
end


---
-- Map:loadData
-- Does nothing by default, override this in a subclass.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function Map:loadData(data)
    local inBrackets = false
    local i = 1
    local length = #data
    local str = ""
    local count = 0

    while i <= length do
        local char = data:sub(i, i)

        if not inBrackets then
            if char == "{" then
                inBrackets = true
            end
        else
            if char == "}" then
                count = count + 1

                local vertices = {}
                for v in str:gmatch("[0-9-]+") do
                    table.insert(vertices, tonumber(v))
                end

                if count == 1 then
                    MapBoundary:new(vertices)
                else
                    StaticDebris:new(vertices)
                end

                str = ""
                inBrackets = false
            elseif char:match("[0-9-,]") then
                str = str .. char
            end
        end

        i = i + 1
    end
end
