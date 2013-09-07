ui = {}
ui.elements = {}
ui.currentCursor = "arrow"
ui.nextId = 1

ui.pressFocus = 0
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

function ui.add(obj)
    if not obj then return false end

    ui.elements[ui.nextId] = obj
    ui.nextId = ui.nextId + 1

    return true
end

function ui.setCursor(type)
    if type ~= ui.currentCursor and ui.cursors[type] then
        love.mouse.setCursor(ui.cursors[type])
        ui.currentCursor = type
    end
end


function ui.mousepressed(x, y, but)
    local keepfocus = fasle

    for k,v in pairs(ui.elements) do
        v.pressing = false

        if v.focussable then
            if x > v.area.x and x < v.area.x + v.area.width and y > v.area.y and y < v.area.y + v.area.height then
                if ui.focus == k then
                    keepfocus = true
                end

                ui.pressFocus = k
                v.pressing = true
                break
            end
        end
    end

    if not keepfocus then
        ui.focus = 0
    end
end

function ui.mousereleased(x, y, but)
    if ui.pressFocus > 0 and ui.elements[ui.pressFocus] then
        local v = ui.elements[ui.pressFocus]
        v.pressing = false

        if v.focussable then
            if x > v.area.x and x < v.area.x + v.area.width and y > v.area.y and y < v.area.y + v.area.height then
                ui.focus = ui.pressFocus

                if v.onfocus then
                    v:onfocus()
                end
            end
        end
    end

    ui.pressFocus = 0
end

function ui.textinput(char)
    if ui.elements[ui.focus].textinput then
        ui.elements[ui.focus]:textinput(char)
    end
end

function ui.keypressed(key, isrepeat)
    if ui.elements[ui.focus].keypressed then
        ui.elements[ui.focus]:keypressed(key, isrepeat)
    end
end
