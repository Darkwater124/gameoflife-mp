fonts = {}

fonts.getGlyph = function (font, glyph)
    local g = fonts[string.lower(font)][string.lower(glyph)]
    local t = {}

    for y,r in pairs(g) do
        for x,c in pairs(r) do
            if c == 1 then
                table.insert(t, {x=x, y=y})
            end
        end
    end

    return t, #g[1]
end

fonts["title"] = {}

    fonts["title"]["a"] = {
        {0,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,1,1,1,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["b"] = {
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,1,1,1,0,0},
    }
    fonts["title"]["c"] = {
        {0,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,0,0},
        {1,0,0,0,1,0},
        {0,1,1,1,0,0},
    }
    fonts["title"]["d"] = {
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,1,1,1,0,0},
    }
    fonts["title"]["e"] = {
        {1,1,1,1,1,0},
        {1,0,0,0,0,0},
        {1,1,1,1,0,0},
        {1,0,0,0,0,0},
        {1,1,1,1,1,0},
    }
    fonts["title"]["f"] = {
        {1,1,1,1,1,0},
        {1,0,0,0,0,0},
        {1,1,1,1,0,0},
        {1,0,0,0,0,0},
        {1,0,0,0,0,0},
    }
    fonts["title"]["g"] = {
        {0,1,1,1,1,0},
        {1,0,0,0,0,0},
        {1,0,1,1,1,0},
        {1,0,0,0,1,0},
        {0,1,1,1,1,0},
    }
    fonts["title"]["h"] = {
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,1,1,1,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["i"] = {
        {1,1,1,0},
        {0,1,0,0},
        {0,1,0,0},
        {0,1,0,0},
        {1,1,1,0},
    }
    fonts["title"]["j"] = {
        {0,0,1,1,1,0},
        {0,0,0,0,1,0},
        {0,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,1,1,1,0,0},
    }
    fonts["title"]["k"] = {
        {1,0,0,0,1,0},
        {1,0,0,1,0,0},
        {1,1,1,0,0,0},
        {1,0,0,1,0,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["l"] = {
        {1,0,0,0,0,0},
        {1,0,0,0,0,0},
        {1,0,0,0,0,0},
        {1,0,0,0,0,0},
        {1,1,1,1,1,0},
    }
    fonts["title"]["m"] = {
        {1,0,0,0,1,0},
        {1,1,0,1,1,0},
        {1,0,1,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["n"] = {
        {1,0,0,0,1,0},
        {1,1,0,0,1,0},
        {1,0,1,0,1,0},
        {1,0,0,1,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["o"] = {
        {0,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,1,1,1,0,0},
    }
    fonts["title"]["p"] = {
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,1,1,1,0,0},
        {1,0,0,0,0,0},
        {1,0,0,0,0,0},
    }
    fonts["title"]["q"] = {
        {0,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,1,1,0},
        {0,1,1,1,1,0},
    }
    fonts["title"]["r"] = {
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,1,1,1,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["s"] = {
        {0,1,1,1,1,0},
        {1,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,1,0},
        {1,1,1,1,0,0},
    }
    fonts["title"]["t"] = {
        {1,1,1,1,1,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
    }
    fonts["title"]["u"] = {
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,1,1,1,0,0},
    }
    fonts["title"]["v"] = {
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
    }
    fonts["title"]["w"] = {
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,1,0,1,0},
        {1,1,0,1,1,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["x"] = {
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,1,0,0},
        {1,0,0,0,1,0},
    }
    fonts["title"]["y"] = {
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
    }
    fonts["title"]["z"] = {
        {1,1,1,1,1,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,0,0,0},
        {1,1,1,1,1,0},
    }
    fonts["title"][" "] = {
        {0,0},
        {0,0},
        {0,0},
        {0,0},
        {0,0},
    }
