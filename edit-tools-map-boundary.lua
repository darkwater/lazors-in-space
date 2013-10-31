return {
    icon = nil,
    label = "Map Boundary",
    activate = function (self)
        self.points = {}
    end,
    update = function (self)
        if game.mousepressed["l"] then
            if #self.points >= 2 and utils.distance(editor.worldmousex, editor.worldmousey, self.points[1].x, self.points[1].y) < 8 then
                local points = {}
                for k,v in pairs(self.points) do
                    table.insert(points, v.x)
                    table.insert(points, v.y)
                end
                MapBoundary:new(unpack(points))
                return true
            else
                table.insert(self.points, { x = editor.worldmousex, y = editor.worldmousey })
            end
        end
    end,
    drawhud = function (self)
        love.graphics.push()
        love.graphics.translate(editor.mousex, editor.mousey)
        love.graphics.rotate((game.time * 2) % (math.pi * 2))
            love.graphics.circle("line", 0, 0, 8, 3)
        love.graphics.pop()
    end,
    drawworld = function (self)
        local points = {}
        for k,v in pairs(self.points) do
            table.insert(points, v.x)
            table.insert(points, v.y)
        end
        if #points >= 4 then
            love.graphics.line(points)
        end

        for k,v in pairs(self.points) do
            love.graphics.circle("line", v.x, v.y, 8, 10)
        end
    end
}
