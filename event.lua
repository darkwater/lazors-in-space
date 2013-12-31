event = {}
event.callbacks = {}


event.listen = function (name, callback)
    
    if not event.callbacks[name] then
        event.callbacks[name] = {}
    end

    table.insert(event.callbacks[name], callback)

end


event.call = function (name, data)
    
    if not event.callbacks[name] then
        return
    end

    for i,v in ipairs(event.callbacks[name]) do
        v(data)
    end

end
