function love.load()
    cells = {
        -- Gosper Glider Gun
        {x= 1, y= 5},
        {x= 2, y= 5},
        {x= 1, y= 6},
        {x= 2, y= 6},
        {x=15, y= 6},
        {x=16, y= 4},
        {x=17, y= 5},
        {x=17, y= 6},
        {x=18, y= 6},
        {x=17, y= 7},
        {x=16, y= 8},
        {x=14, y= 3},
        {x=13, y= 3},
        {x=12, y= 4},
        {x=11, y= 5},
        {x=11, y= 6},
        {x=11, y= 7},
        {x=12, y= 8},
        {x=13, y= 9},
        {x=14, y= 9},
        {x=21, y= 3},
        {x=21, y= 4},
        {x=21, y= 5},
        {x=22, y= 3},
        {x=22, y= 4},
        {x=22, y= 5},
        {x=23, y= 2},
        {x=23, y= 6},
        {x=25, y= 1},
        {x=25, y= 2},
        {x=25, y= 6},
        {x=25, y= 7},
        {x=35, y= 3},
        {x=35, y= 4},
        {x=36, y= 3},
        {x=36, y= 4},

        {x=39, y=29},
        {x=40, y=29},
        {x=39, y=30},
        {x=40, y=30},

        {x=79-  1, y=59-  5},
        {x=79-  2, y=59-  5},
        {x=79-  1, y=59-  6},
        {x=79-  2, y=59-  6},
        {x=79- 15, y=59-  6},
        {x=79- 16, y=59-  4},
        {x=79- 17, y=59-  5},
        {x=79- 17, y=59-  6},
        {x=79- 18, y=59-  6},
        {x=79- 17, y=59-  7},
        {x=79- 16, y=59-  8},
        {x=79- 14, y=59-  3},
        {x=79- 13, y=59-  3},
        {x=79- 12, y=59-  4},
        {x=79- 11, y=59-  5},
        {x=79- 11, y=59-  6},
        {x=79- 11, y=59-  7},
        {x=79- 12, y=59-  8},
        {x=79- 13, y=59-  9},
        {x=79- 14, y=59-  9},
        {x=79- 21, y=59-  3},
        {x=79- 21, y=59-  4},
        {x=79- 21, y=59-  5},
        {x=79- 22, y=59-  3},
        {x=79- 22, y=59-  4},
        {x=79- 22, y=59-  5},
        {x=79- 23, y=59-  2},
        {x=79- 23, y=59-  6},
        {x=79- 25, y=59-  1},
        {x=79- 25, y=59-  2},
        {x=79- 25, y=59-  6},
        {x=79- 25, y=59-  7},
        {x=79- 35, y=59-  3},
        {x=79- 35, y=59-  4},
        {x=79- 36, y=59-  3},
        {x=79- 36, y=59-  4},
    }

    img = love.graphics.newImage("res/background.png")
    img:setFilter("linear", "linear")

    grid = love.graphics.newCanvas(800, 600)

    love.graphics.setCanvas(grid)
    love.graphics.setColor(255, 255, 255, 255)
    for x = 1, 80 do
        love.graphics.line(x*10 -.5, 0, x*10 -.5, 600)
    end
    for y = 1, 60 do
        love.graphics.line(0, y*10 -.5, 800, y*10 -.5)
    end
    love.graphics.setColor(255, 255, 255, 150)
    for x = 1, 80 do
        love.graphics.line(x*10 +.5, 0, x*10 +.5, 600)
    end
    for y = 1, 60 do
        love.graphics.line(0, y*10 +.5, 800, y*10 +.5)
    end
    love.graphics.setCanvas()

    timer = 0
    ticktime = 0.1
    generation = 1

    check = {}
end

function love.update(dt)
    timer = timer + dt
    if timer > ticktime then
        check = {}
        for k,v in pairs(cells) do
            for x = v.x-1, v.x+1 do
                for y = v.y-1, v.y+1 do
                    if not check[x] then check[x] = {} end
                    if not check[x][y] or check[x][y] == 0 then check[x][y] = (x == v.x and y == v.y) and k or 0 end
                end
            end
        end

        for x,r in pairs(check) do
            for y,c in pairs(r) do
                local neighbours = 0
                for xc = x-1, x+1 do
                    for yc = y-1, y+1 do
                        if not (xc == x and yc == y) and check[xc] and check[xc][yc] and check[xc][yc] > 0 then
                            neighbours = neighbours + 1
                        end
                    end
                end
                if neighbours < 2 or neighbours > 3 then
                    cells[c] = nil
                end
                if c == 0 and neighbours == 3 then
                    table.insert(cells, {x=x, y=y})
                end
            end
        end

        generation = generation + 1
        timer = timer - ticktime
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(img, 0, 0, 0, 800, 600, 0.5, 0.5)

    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.draw(grid, 0, 0)

    love.graphics.push()
        -- love.graphics.translate(400, 300)
        love.graphics.scale(10)

        love.graphics.setColor(251, 253, 255, 255)
        for k,v in pairs(cells) do
            love.graphics.rectangle("fill", v.x, v.y, 1, 1)
        end
    love.graphics.pop()
end
