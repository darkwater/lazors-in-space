editor.tools = {}
editor.tools.tools = {}
editor.tools.active = 0
editor.tools.y = 70
editor.tools.width = 200
editor.tools.height = 40
editor.tools.hovering = 0

table.insert(editor.tools.tools, require("edit-tools-static-debris"))


editor.tools.update = function (dt)
    local mousex = love.mouse.getX()
    local mousey = love.mouse.getY()

    if mousex < editor.tools.width and mousey > editor.tools.y and mousey < editor.tools.y + editor.tools.height * #editor.tools.tools then
        editor.tools.hovering = math.floor((mousey - editor.tools.y) / editor.tools.height) + 1

        if game.mousepressed["l"] then
            if editor.tools.active > 0 then -- cancel
                editor.tools.active = 0
            else

                local v = editor.tools.tools[editor.tools.hovering]
                if v then

                    if v.click then v:click() end
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

        if tool.draw then tool:draw() end


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
end
