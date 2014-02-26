util = {}

util.distance = function (x1, y1, x2, y2)

    return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)

end

util.screenToWorld = function (x, y)

    x = x - game.camerax / game.zoom - love.window:getWidth()  / 2
    y = y - game.cameray / game.zoom - love.window:getHeight() / 2
    return x, y

end

util.randomAngle = function ()

    return math.random(1, 360) / 180 * math.pi

end

util.pointInRectangle = function (rx, ry, rw, rh, px, py)

    return px >= rx and py >= ry and px <= rx + rw and py <= ry + rh

end

util.pointInPolygon = function (poly, px, py) -- poly in the form of {x1, y1, x2, y2, x3, y3, ...}

    local collide = 0

    for i = 1, #poly, 2 do

        local x1, y1 = poly[i], poly[i+1]
        local x2, y2 = poly[(i+2-1) % #poly + 1], poly[(i+3-1) % #poly + 1]

        local minx, maxx = math.min(x1, x2), math.max(x1, x2)
        local miny, maxy = math.min(y1, y2), math.max(y1, y2)

        if py > miny and py <= maxy then

            if px > maxx then

                collide = collide + 1

            elseif px >= minx then

                if x2 < x1 then

                    x1, x2 = x2, x1
                    y1, y2 = y2, y1

                end

                local xi = (px - x1) / (x2 - x1)
                local yi = (py - y1) / (y2 - y1)

                if xi > yi then

                    collide = collide + 1

                end

            end

        end

    end

    return collide % 2 == 1

end
