return {
    icon = nil,
    label = "Static Debris",
    click = function (self)

    end,
    update = function (self)

    end,
    draw = function (self)
        love.graphics.circle("line", love.mouse.getX(), love.mouse.getY(), 5, 10)
    end
}
