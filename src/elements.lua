elements = {}

function elements.text(obj)
    obj = validateOptions(obj, {
        text  = { type= "string", required= true                },
        x     = { type= "number", required= true                },
        y     = { type= "number", required= true                },
        scale = { type= "number", default= 5                    },
        color = { type= "table",  default= {255, 255, 255, 230} },
    })

    if not obj then return false end

    obj.tabindex = 0
    obj.focussable = false

    obj.draw = function (self)
        love.graphics.setColor(self.color)
        love.graphics.print(self.text, self.x, self.y, 0, self.scale, self.scale, 0, 1)
    end

    return obj
end

function elements.textinput(obj)
    obj = validateOptions(obj, {
        label          = { type= "string",  default= ""     },
        value          = { type= "string",  default= ""     },
        x              = { type= "number",  required= true  },
        y              = { type= "number",  required= true  },
        width          = { type= "number",  default= 300    },
        scale          = { type= "number",  default= 5      },
        tabindex       = { type= "number",  default= 0      },
        disabled       = { type= "boolean", default= false  },
        selectionstart = { type= "number",  default= 0      },
        selectionend   = { type= "number",  default= 0      },
    })

    if not obj then return false end

    obj.focussable = true
    obj.area = {
        x      = obj.x,
        y      = obj.y,
        width  = obj.width,
        height = 11 * obj.scale,
        cursor = "ibeam"
    }

    obj.setCursor = function (self, pos)
        self.selectionstart = pos
        self.selectionend = pos
    end

    obj.textinput = function (self, char)
        self.value = self.value:sub(1, math.min(self.selectionstart, self.selectionend)) .. char:lower() .. self.value:sub(math.max(self.selectionstart, self.selectionend)+1, #self.value)
        self:setCursor(math.min(self.selectionstart, self.selectionend) + 1)
    end

    obj.mousepressed = function (self, x, y, but)
        local textx = self.x + 3 * self.scale
        self:setCursor(0)

        for i=1, #self.value do
            if textx + fonts.A:getWidth(self.value:sub(1, i)) * self.scale < x + self.scale * 3 then
                self.selectionend = i
            else
                break
            end
        end
    end

    obj.update = function (self)
        if not self.focussed or not love.mouse.isDown("l") then return end

        local textx = self.x + 3 * self.scale
        self.selectionstart = 0

        for i=1, #self.value do
            if textx + fonts.A:getWidth(self.value:sub(1, i)) * self.scale < love.mouse.getX() + self.scale * 3 then
                self.selectionstart = i
            else
                break
            end
        end
    end

    obj.keypressed = function (self, key, isrepeat)
        if key == "backspace" then
            self.value = self.value:sub(1, math.max(0, self.selectionend - 1)) .. self.value:sub(self.selectionend+1, #self.value)
            self:setCursor(self.selectionstart - 1)
        end

        if key == "left" then
            self:setCursor(self.selectionstart - 1)
        end
        if key == "right" then
            self:setCursor(self.selectionstart + 1)
        end
    end

    obj.draw = function (self)
        self.selectionstart = math.max(0, math.min(#self.value, self.selectionstart))
        self.selectionend = math.max(0, math.min(#self.value, self.selectionend))

        local lightness = self.focussed and 0 or 30
        love.graphics.setColor(lightness, lightness, lightness, 200)
        love.graphics.rectangle("fill", self.x, self.y, self.width, 11 * self.scale)

        if self.pressing or self.focussed then
            love.graphics.setColor(250, 200, 100)
        else
            love.graphics.setColor(250, 250, 250)
        end
        love.graphics.setLineWidth(self.scale)
        love.graphics.rectangle("line", self.x + self.scale / 2, self.y + self.scale / 2, self.width - self.scale, 10 * self.scale)

        local textx = self.x + 3 * self.scale
        local texty = self.y + 3 * self.scale
        love.graphics.setScissor(self.x + self.scale, self.y + self.scale, self.width - self.scale * 2, 11 * self.scale)
        if not self.focussed and self.value == "" then
            love.graphics.setColor(150, 150, 150)
            love.graphics.print(self.label, textx, texty, 0, self.scale, self.scale, 0, 1)
        elseif self.value ~= "" or self.focussed then
            if self.selectionend ~= self.selectionstart then
                love.graphics.setColor(50, 100, 220, 200)
                local startx = textx + fonts.A:getWidth(self.value:sub(1, math.min(self.selectionstart, self.selectionend))) * self.scale
                local width = fonts.A:getWidth(self.value:sub(math.min(self.selectionstart, self.selectionend)+1, math.max(self.selectionstart, self.selectionend))) * self.scale
                love.graphics.rectangle("fill", startx, self.y + self.scale, width, 9 * self.scale)
            end

            love.graphics.setColor(250, 250, 250)
            love.graphics.print(self.value, textx, texty, 0, self.scale, self.scale, 0, 1)

            if self.focussed and uptime % 1.1 < 0.55 then
                love.graphics.setColor(200, 200, 200)
                local x = textx + fonts.A:getWidth(self.value:sub(1, self.selectionstart)) * self.scale
                love.graphics.setLineWidth(2)
                love.graphics.line(x, texty - self.scale - .5, x, texty + self.scale * 6 + .5)
            end
        end
        love.graphics.setScissor()
    end

    return obj
end

function elements.button(obj)
    obj = validateOptions(obj, {
        label    = { type= "string",   default= ""               },
        x        = { type= "number",   required= true            },
        y        = { type= "number",   required= true            },
        width    = { type= "number",   default= 100              },
        scale    = { type= "number",   default= 5                },
        tabindex = { type= "number",   default= 0                },
        callback = { type= "function", default= function () end  },
    })

    if not obj then return false end

    obj = validateOptions(obj, {
        height   = { type= "number",   default= 11 * obj.scale   },
    })

    obj.focussable = true
    obj.area = {
        x      = obj.x,
        y      = obj.y,
        width  = obj.width,
        height = obj.height,
        cursor = "hand"
    }

    obj.draw = function (self)
        local lightness = (self.hovering and not self.pressing) and 150 or 100
        love.graphics.setColor(lightness, lightness, lightness, 240)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

        if self.pressing or self.focussed then
            love.graphics.setColor(250, 200, 100)
        else
            love.graphics.setColor(250, 250, 250)
        end
        love.graphics.setLineWidth(self.scale)
        love.graphics.rectangle("line", self.x + self.scale / 2, self.y + self.scale / 2, self.width - self.scale, self.height - self.scale)

        if not self.pressing then
            love.graphics.setColor(250, 250, 250)
        end
        love.graphics.printf(self.label, self.x, self.y + 3 * self.scale, self.width / self.scale, "center", 0, self.scale, self.scale, 0, 1)
    end

    obj.onfocus = obj.callback

    return obj
end
