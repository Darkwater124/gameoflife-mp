function love.load()

    -- Includes --
        require("enet")
        require("json")

        require("utils")
        require("patterns")
        require("fonts")
        require("life")
        require("elements")
        require("lobby")
        require("ui")
        require("net")
    --------------


    -- Initialization --
        life.cells = patterns.merge({}, patterns.bunnies, 36, 55, 0)

        background = love.graphics.newImage("res/background_grayscale.png")
        background:setFilter("linear", "linear")

        love.keyboard:setKeyRepeat(true)
    ----------------------


    -- Generate grid --
        grid_canvas = love.graphics.newCanvas(800, 600)

        love.graphics.setCanvas(grid_canvas)
        love.graphics.setColor(255, 255, 255, 255) 
        for x = 1, 80 do
            love.graphics.line(x*10 -.5, 0, x*10 -.5, 600)
        end
        for y = 1, 60 do
            love.graphics.line(0, y*10 -.5, 800, y*10 -.5)
        end

        -- Inset grid for extra depth
        love.graphics.setColor(255, 255, 255, 150)
        for x = 1, 80 do
            love.graphics.line(x*10 +.5, 0, x*10 +.5, 600)
        end
        for y = 1, 60 do
            love.graphics.line(0, y*10 +.5, 800, y*10 +.5)
        end
        love.graphics.setCanvas()
    -------------------


    -- Set up UI --
        ui.add(elements.text({ text  = "game of",  x = 210, y =  20, scale = 10 }))
        ui.add(elements.text({ text  = "lIfe mp",  x = 210, y =  80, scale = 10 })) -- Capital I is 5x5, lowercase i is 3x5


        -- Join --
            ui.add(elements.text({ text  = "join",     x = 100, y = 200, scale =  8 }))
            ui.add("ipaddr", elements.textinput({ label = "ip address", x =  50, y = 260, width = 270, scale = 3, tabindex = 1 }))
            ui.add("port",   elements.textinput({ label = "port",       x =  50, y = 300, width = 150, scale = 3, tabindex = 2 }))

            ui.add(elements.button({ label = "join", x = 210, y = 300, width = 110, scale = 3, tabindex = 3, callback = function ()
                net.username = ui.getElementById("username").value
                net.joinLobby(ui.getElementById("ipaddr").value, ui.getElementById("port").value)
            end }))
        ----------


        -- Host --
            ui.add(elements.text({ text  = "host",     x = 516, y = 200, scale =  8 }))
            ui.add("hostport", elements.textinput({ label = "port", x = 480, y = 260, width = 150, scale = 3, tabindex = 12 }))

            ui.add(elements.button({ label = "host", x = 640, y = 260, width = 110, scale = 3, tabindex = 13, callback = function ()
                net.username = ui.getElementById("username").value
                net.startHostingLobby(ui.getElementById("hostport").value)
                lobby.setHostname(net.username)
            end }))
        ----------


        -- Options --
            ui.add(elements.text({ text  = "nickname",  x = 50, y = 480, scale =  3 }))
            ui.add("username", elements.textinput({ value = "darkwater", x = 50, y = 500, width = 150, scale = 2, tabindex = 21 }))
        -------------
    ---------------


    uptime = 0
    timer = 0
    ticktime = 0.2
end

function love.update(dt)
    uptime = uptime + dt

    net.update()

    timer = timer + dt
    if timer > ticktime then

        -- Next generation
        life.nextgen()

        timer = timer - ticktime
    end

    ui.update()
end

function love.draw()
    love.graphics.setLineWidth(1)

    -- Background and grid
    local r,g,b,a = HSL(life.generation % 360, 1, 0.9, 1)
    love.graphics.setColor(r * 255, g * 255, b * 255, a * 255)
    love.graphics.draw(background, 0, 0, 0, 800, 600, 0.5, 0.5)

    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.draw(grid_canvas, 0, 0)


    -- Draw life
    love.graphics.setColor(255, 255, 255, 100)
    life.draw()


    -- Draw UI
    ui.draw()
end

function love.mousepressed(x, y, but)
    ui.mousepressed(x, y, but)
end

function love.mousereleased(x, y, but)
    ui.mousereleased(x, y, but)
end

function love.textinput(char)
    ui.textinput(char)
end

function love.keypressed(key, isrepeat)
    ui.keypressed(key, isrepeat)

    if key == "up" then
        ticktime = ticktime * 1.05
    elseif key == "down" then
        ticktime = ticktime / 1.05
    end
end

function love.keyreleased(key)
    ui.keyreleased(key)
end

function love.quit()
    net.shutdown()
end
