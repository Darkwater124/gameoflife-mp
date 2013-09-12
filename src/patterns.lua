patterns = {}

patterns.merge = function (tbl, patt, x, y)
    for _,v in pairs(patt) do
        local tx, ty = v.x + x, v.y + y
        table.insert(tbl, {x=tx, y=ty})
    end

    return tbl
end

patterns.gospergun = {
    -- Gosper Glider Guns
    {x= 1, y= 5}, {x= 2, y= 5}, {x= 1, y= 6}, {x= 2, y= 6}, {x=15, y= 6}, {x=16, y= 4},
    {x=17, y= 5}, {x=17, y= 6}, {x=18, y= 6}, {x=17, y= 7}, {x=16, y= 8}, {x=14, y= 3},
    {x=13, y= 3}, {x=12, y= 4}, {x=11, y= 5}, {x=11, y= 6}, {x=11, y= 7}, {x=12, y= 8},
    {x=13, y= 9}, {x=14, y= 9}, {x=21, y= 3}, {x=21, y= 4}, {x=21, y= 5}, {x=22, y= 3},
    {x=22, y= 4}, {x=22, y= 5}, {x=23, y= 2}, {x=23, y= 6}, {x=25, y= 1}, {x=25, y= 2},
    {x=25, y= 6}, {x=25, y= 7}, {x=35, y= 3}, {x=35, y= 4}, {x=36, y= 3}, {x=36, y= 4},
}

patterns.pentoad = {
    -- Pentoad
    {x= 12, y=  0}, {x= 11, y=  0}, {x= 11, y=  1}, {x= 11, y=  2},
    {x=  9, y=  2}, {x=  9, y=  3}, {x= 10, y=  3},

    {x=  5, y=  4}, {x=  6, y=  4}, {x=  6, y=  5},
    {x=  6, y=  6}, {x=  6, y=  7}, {x=  7, y=  7},

    {x=  3, y=  9}, {x=  3, y=  8}, {x=  2, y=  8},
    {x=  1, y=  9}, {x=  1, y= 10}, {x=  1, y= 11}, {x=  0, y= 11},
}

patterns.galaxy = {
    -- Kok's galaxy
    {x= 3, y= 3}, {x= 6, y= 3}, {x=10, y= 6}, {x= 3, y=10},
    {x= 4, y= 3}, {x= 6, y= 4}, {x=11, y= 6}, {x= 3, y=11},
    {x= 3, y= 4}, {x= 7, y= 3}, {x=10, y= 7}, {x= 4, y=10},
    {x= 4, y= 4}, {x= 7, y= 4}, {x=11, y= 7}, {x= 4, y=11},
    {x= 3, y= 5}, {x= 8, y= 3}, {x=10, y= 8}, {x= 5, y=10},
    {x= 4, y= 5}, {x= 8, y= 4}, {x=11, y= 8}, {x= 5, y=11},
    {x= 3, y= 6}, {x= 9, y= 3}, {x=10, y= 9}, {x= 6, y=10},
    {x= 4, y= 6}, {x= 9, y= 4}, {x=11, y= 9}, {x= 6, y=11},
    {x= 3, y= 7}, {x=10, y= 3}, {x=10, y=10}, {x= 7, y=10},
    {x= 4, y= 7}, {x=10, y= 4}, {x=11, y=10}, {x= 7, y=11},
    {x= 3, y= 8}, {x=11, y= 3}, {x=10, y=11}, {x= 8, y=10},
    {x= 4, y= 8},
}

patterns.bunnies = {
    -- Bunnies
    {x= 0, y= 0},
    {x= 2, y= 1},
    {x= 2, y= 2},
    {x= 1, y= 3},
    {x= 3, y= 3},
    {x= 6, y= 0},
    {x= 6, y= 1},
    {x= 5, y= 2},
    {x= 7, y= 2},
}

patterns.lwss = {
    -- LWSS (LightWeight Space Ship)
    {x= 0, y= 0}, {x= 3, y= 0}, {x= 4, y= 1}, {x= 4, y= 2}, 
    {x= 4, y= 3}, {x= 3, y= 3}, {x= 2, y= 3}, {x= 1, y= 3}, {x= 0, y= 2},
}

patterns.diehard = {
    -- Die Hard
    {x= 0, y= 1}, {x= 1, y= 1}, {x= 1, y= 2}, {x= 6, y= 0},
    {x= 5, y= 2}, {x= 6, y= 2}, {x= 7, y= 2},
}
