editor.tools = {}
editor.tools.tools = {}
editor.tools.active = 0
editor.tools.y = 70
editor.tools.width = 200
editor.tools.height = 40
editor.tools.hovering = 0
editor.tools.gridsize = 10

table.insert(editor.tools.tools, require("edit-tools-static-debris"))
table.insert(editor.tools.tools, require("edit-tools-map-boundary"))


editor.tools.update = function (dt)
    local mousex = love.mouse.getX()
    local mousey = love.mouse.getY()
    editor.mousex = math.floor(mousex / editor.tools.gridsize + 0.5) * editor.tools.gridsize
    editor.mousey = math.floor(mousey / editor.tools.gridsize + 0.5) * editor.tools.gridsize
    editor.worldmousex = math.floor(game.mousex / editor.tools.gridsize + 0.5) * editor.tools.gridsize
    editor.worldmousey = math.floor(game.mousey / editor.tools.gridsize + 0.5) * editor.tools.gridsize
    -- editor.worldmousex, editor.worldmousey = utils.screenToWorld(editor.mousex, editor.mousey)

    if editor.tools.active > 0 then
        local v = editor.tools.tools[editor.tools.active]
        if v then

            if v.update then
                if v:update() then
                    editor.tools.active = 0
                end
            end

        end
    end

    if mousex < editor.tools.width and mousey > editor.tools.y and mousey < editor.tools.y + editor.tools.height * (editor.tools.active > 0 and 1 or #editor.tools.tools) then
        editor.tools.hovering = math.floor((mousey - editor.tools.y) / editor.tools.height) + 1

        if game.mousepressed["l"] then
            if editor.tools.active > 0 then -- cancel
                editor.tools.active = 0
            else

                local v = editor.tools.tools[editor.tools.hovering]
                if v then

                    if v.activate then v:activate() end
                    editor.tools.active = editor.tools.hovering
                   
                end

            end
        end
    else
        editor.tools.hovering = 0
    end
end


editor.tools.draw = function ()
    if editor.tools.hovering > 0 then
        love.graphics.rectangle("fill", 0, (editor.tools.hovering - 1) * editor.tools.height + editor.tools.y, 2, editor.tools.height)
    end

    if editor.tools.active > 0 then
        local tool = editor.tools.tools[editor.tools.active]

        if tool.drawhud then tool:drawhud() end

        if tool.drawworld then
            love.graphics.push()
            love.graphics.translate(math.floor(game.camerax) + .5 + love.window:getWidth() / 2, math.floor(game.cameray) + .5 + love.window:getHeight()/2)
            love.graphics.scale(game.zoom)
                tool:drawworld()
            love.graphics.pop()
        end


        love.graphics.setFont(fonts.droidsans[16])
        love.graphics.setColor(250, 251, 255)
        love.graphics.print("Cancel", 50, editor.tools.y + 10)

    else

        love.graphics.setFont(fonts.droidsans[16])
        love.graphics.setColor(250, 251, 255)

        local y = editor.tools.y

        for k,v in pairs(editor.tools.tools) do
            love.graphics.print(v.label, 50, y + 10)
            y = y + editor.tools.height
        end

    end

    love.graphics.printf("Grid\n" .. editor.tools.gridsize, love.graphics.getWidth() - 100, 10, 100, "center")
end
