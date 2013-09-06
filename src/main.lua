function love.load()

    -- Includes --
        require("patterns")
        require("fonts")
        require("life")
    --------------


    -- Initialization --
        life.cells = galaxy

        background = love.graphics.newImage("res/background.png")
        background:setFilter("linear", "linear")
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
        life.addText("Game of Life", 16, 5, "title")
    ---------------


    timer = 0
    ticktime = 0.2
end

function love.update(dt)

    timer = timer + dt
    if timer > ticktime then

        -- Next generation
        life.nextgen()

        timer = timer - ticktime
    end
end

function love.draw()

    -- Background and grid
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(background, 0, 0, 0, 800, 600, 0.5, 0.5)

    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.draw(grid_canvas, 0, 0)


    -- Draw life
    life.draw()
end
