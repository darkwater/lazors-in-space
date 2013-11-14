utils = {}

utils.distance = function (x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

utils.screenToWorld = function (x, y)
    x = x - game.camerax / game.zoom - love.window:getWidth()  / 2
    y = y - game.cameray / game.zoom - love.window:getHeight() / 2
    return x, y
end

utils.randomAngle = function ()
    return math.random(1, 360) / 180 * math.pi
end
