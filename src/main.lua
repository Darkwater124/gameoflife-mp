function love.load()
    cells = {
        {x=  0, y=  0},
        {x=  1, y=  0},
        {x=  0, y=  1},
        {x= -1, y=  1},
        {x= -1, y= -1},
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
end

function love.update()

end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(img, 0, 0, 0, 800, 600, 0.5, 0.5)

    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.draw(grid, 0, 0)

    love.graphics.push()
        love.graphics.translate(400, 300)
        love.graphics.scale(10)
        love.graphics.setColor(251, 253, 255, 255)
        for k,v in pairs(cells) do
            love.graphics.rectangle("fill", v.x, v.y, 1, 1)
        end
    love.graphics.pop()
end
