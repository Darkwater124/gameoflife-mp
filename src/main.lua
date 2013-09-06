function love.load()

    -- Includes --
        require("patterns")
    --------------


    -- Init global vars --
        cells = galaxy

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


    timer = 0
    ticktime = 1
    generation = 1
end

function love.update(dt)

    timer = timer + dt
    if timer > ticktime then
        -- Next generation
        local check = {}

        -- Add live cells and neighbours to table to check
        for k,v in pairs(cells) do
            for x = v.x-1, v.x+1 do
                for y = v.y-1, v.y+1 do
                    if not check[x] then check[x] = {} end
                    if not check[x][y] or check[x][y] == 0 then check[x][y] = (x == v.x and y == v.y) and k or 0 end
                end
            end
        end

        -- Iterate through live cells and neighbours
        for x,r in pairs(check) do
            for y,c in pairs(r) do

                -- Count neighbours
                local neighbours = 0
                for xc = x-1, x+1 do
                    for yc = y-1, y+1 do
                        if not (xc == x and yc == y) and check[xc] and check[xc][yc] and check[xc][yc] > 0 then
                            neighbours = neighbours + 1
                        end
                    end
                end

                -- Under-/overpopulation
                if neighbours < 2 or neighbours > 3 then
                    cells[c] = nil
                end

                -- Birth to a new cell
                if c == 0 and neighbours == 3 then
                    table.insert(cells, {x=x, y=y})
                end
            end
        end

        -- Increase generation counter and reset timer
        generation = generation + 1
        timer = timer - ticktime
    end
end

function love.draw()

    -- Background and grid
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(background, 0, 0, 0, 800, 600, 0.5, 0.5)

    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.draw(grid_canvas, 0, 0)


    -- Draw all cells
    love.graphics.push()
        -- love.graphics.translate(400, 300) -- Move 0,0 on grid to x,y on screen
        love.graphics.scale(10)

        -- Draw cells
        love.graphics.setColor(251, 253, 255, 255)
        for k,v in pairs(cells) do
            love.graphics.rectangle("fill", v.x, v.y, 1, 1)
        end
    love.graphics.pop()
end
