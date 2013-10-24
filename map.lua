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
    local inComment  = false
    local className  = ""
    local objects    = {}
    local arguments  = {}
    local i          = 1
    local length     = #data
    local nestLevel  = 0

    while i <= length do
        local char = data:sub(i, i)

        if char == " " and nestLevel == 0 then
            -- do nothing

        elseif not inComment and char == "/" and data:sub(i+1, i+1) == "/" then
            inComment = true

        elseif inComment then
            inComment = not (char == "\n")

        elseif not inBrackets then
            -- look for the next object

            if char == "{" then -- Opening bracket
                inBrackets = true
                className  = ""
                arguments  = {}
            end

        else
            -- in an object

            if #arguments == 0 then
                -- in classname

                if char == ":" then
                    arguments[1] = ""
                elseif char ~= " " then
                    className = className .. char
                end

            else

                if char == "{" or char == "[" then
                    nestLevel = nestLevel + 1
                elseif (char == "}" or char == "]") and nestLevel > 0 then
                    nestLevel = nestLevel - 1
                end

                if char == "," and nestLevel == 0 then
                    arguments[#arguments+1] = ""
                elseif char == "}" and nestLevel == 0 then
                    -- finished object

                    for k,v in pairs(arguments) do
                        if tonumber(v) ~= nil then
                            arguments[k] = tonumber(v)
                        elseif "[" .. v:sub(2, #v - 1) .. "]" == v or "{" .. v:sub(2, #v - 1) .. "}" == v then
                            arguments[k] = json.decode(v)
                        end
                    end

                    table.insert(objects, { className = className, arguments = arguments });
                    inBrackets = false
                    className = ""
                    arguments = {}
                else
                    arguments[#arguments] = arguments[#arguments] .. char
                end

            end

        end

        i = i + 1
    end

    for k,v in pairs(objects) do
        _G[v.className]:new(unpack(v.arguments))
    end
end
