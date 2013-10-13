editor.tools = {}
editor.tools.tools = {}
editor.tools.active = 0
editor.tools.y = 70
editor.tools.width = 200
editor.tools.height = 40
require("edit-tools-static-debris")


editor.tools.update = function (dt)
    if game.mousepressed["l"] and love.mouse.getX() < editor.tools.width then
        if editor.tools.active > 0 then

            local mousey = love.mouse.getY()

            if mousey > editor.tools.y and mousey < editor.tools.y + editor.tools.height then
                editor.tools.active = 0
            end

        else

            local mousey = love.mouse.getY()

            local y = editor.tools.y
            for k,v in pairs(editor.tools.tools) do
                if mousey > y and mousey < y + editor.tools.height then
                    
                    if v.click then v:click() end
                    editor.tools.active = k

                    break
                end
                y = y + editor.tools.height
            end

        end
    end
end


editor.tools.draw = function ()
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
