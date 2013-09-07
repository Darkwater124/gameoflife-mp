ui = {}
ui.elements = {}
ui.stringIds = {}
ui.currentCursor = "default"
ui.nextId = 1
ui.focus = 0

-- Init cursors --
    ui.cursors = {}
    ui.cursors.arrow     = love.mouse.newCursor("arrow")
    ui.cursors.waitarrow = love.mouse.newCursor("waitarrow")
    ui.cursors.hand      = love.mouse.newCursor("hand")
    ui.cursors.ibeam     = love.mouse.newCursor("ibeam")
    ui.cursors.default   = ui.cursors.arrow
    ui.cursors.pointer   = ui.cursors.hand
------------------

function ui.update()
    local defcur = true

    local mousex, mousey = love.mouse.getPosition()

    for k,v in pairs(ui.elements) do
        v.focussed = false

        if v.focussable then
            v.focussed = ui.focus == k

            v.hovering = mousex > v.area.x and mousex < v.area.x + v.area.width and mousey > v.area.y and mousey < v.area.y + v.area.height
            if v.hovering then
                defcur = false
                ui.setCursor(v.area.cursor)
            end
        end

        if v.update then
            v:update()
        end
    end

    if defcur then
        ui.setCursor("default")
    end
end

function ui.draw()
    love.graphics.setFont(fonts.A)

    for k,v in pairs(ui.elements) do
        if v.draw then
            v:draw()
        end
    end
end

function ui.add(id, obj)
    if type(id) == "table" then
        obj = id
        id = nil
    end

    if not obj then return false end

    if id then
        if ui.stringIds[id] then
            error("ID " .. id .. " is already in use!")
        else
            ui.stringIds[id] = ui.nextId
        end
    end

    ui.elements[ui.nextId] = obj

    ui.nextId = ui.nextId + 1
    return obj, ui.nextId - 1
end

function ui.getElementById(id)
    if not id or not ui.stringIds[id] then
        return nil
    end

    return ui.elements[ui.stringIds[id]]
end

function ui.setCursor(type)
    if type ~= ui.currentCursor and ui.cursors[type] then
        love.mouse.setCursor(ui.cursors[type])
        ui.currentCursor = type
    end
end

function ui.setFocus(id)
    if not ui.elements[id] then return end

    ui.focus = id
    ui.elements[id].focussed = true

    if ui.elements[id].onfocus then
        ui.elements[id]:onfocus()
    end
end


function ui.mousepressed(x, y, but)
    local gotFocus = false

    for k,v in pairs(ui.elements) do
        v.pressing = false

        if v.focussable then
            if x > v.area.x and x < v.area.x + v.area.width and y > v.area.y and y < v.area.y + v.area.height then
                if ui.focus ~= k then
                    ui.setFocus(k)
                end

                if v.mousepressed then
                    v:mousepressed(x, y, but)
                end

                gotFocus = true
                v.pressing = true
                break
            end
        end
    end

    if not gotFocus then
        if ui.elements[ui.focus] then
            ui.elements[ui.focus].focussed = false
        end

        ui.focus = 0
    end
end

function ui.mousereleased(x, y, but)
    for k,v in pairs(ui.elements) do
        v.pressing = false
    end

    if ui.elements[ui.focus] and ui.elements[ui.focus].mousereleased and x > v.area.x and x < v.area.x + v.area.width and y > v.area.y and y < v.area.y + v.area.height then
        ui.elements[ui.focus]:mousereleased(x, y, but)
    end
end

function ui.textinput(char)
    if ui.elements[ui.focus] and ui.elements[ui.focus].textinput then
        ui.elements[ui.focus]:textinput(char)
    end
end

function ui.keypressed(key, isrepeat)                                           -- For some reason, 0 evaluates to true -_-
    if key == "tab" and ui.elements[ui.focus] and ui.elements[ui.focus].tabindex and ui.elements[ui.focus].tabindex > 0 then
        local targettab = 99999999
        local target = 0

        for k,v in pairs(ui.elements) do
            if v.tabindex and v.tabindex > ui.elements[ui.focus].tabindex and v.tabindex < targettab then
                targettab = v.tabindex
                target = k
            end
        end

        if target > 0 then
            ui.setFocus(target)
        end

        return
    end

    if ui.elements[ui.focus] and ui.elements[ui.focus].keypressed then
        ui.elements[ui.focus]:keypressed(key, isrepeat)
    end
end
