life = {}
life.cells = {}
life.ui = {}
life.generation = 1

function life.addText(text, x, y, font)
    local xpos = 0

    for c in text:gmatch "." do
        local glyph, width = fonts.getGlyph(font, c)

        for k,v in pairs(glyph) do
            v.x = v.x + x - 1 + xpos
            v.y = v.y + y - 1
            table.insert(life.ui, v)
        end

        xpos = xpos + width
    end
end

function life.nextgen()
    local check = {}


    -- Add live cells and neighbours to table to check
    for k,v in pairs(life.cells) do
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
                life.cells[c] = nil
            end

            -- Birth to a new cell
            if c == 0 and neighbours == 3 then
                table.insert(life.cells, {x=x, y=y})
            end
        end
    end


    -- Remove nil values from between cells
    local _cells = {}
    for i=1, table.maxn(life.cells) do
        if life.cells[i] then
            table.insert(_cells, life.cells[i])
        end
    end
    life.cells = _cells


    -- Increase generation counter and reset timer
    life.generation = life.generation + 1
end

function life.draw()
    love.graphics.push()
        -- love.graphics.translate(400, 300) -- Move 0,0 on grid to x,y on screen
        love.graphics.scale(10)

        -- Draw cells
        love.graphics.setColor(251, 253, 255, 255)
        for k,v in pairs(life.cells) do
            love.graphics.rectangle("fill", v.x, v.y, 1, 1)
        end

        -- Draw UI
        love.graphics.setColor(251, 253, 255, 255)
        for k,v in pairs(life.ui) do
            love.graphics.rectangle("fill", v.x, v.y, 1, 1)
        end
    love.graphics.pop()
end
