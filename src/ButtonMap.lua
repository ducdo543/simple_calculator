ButtonMap = Class{}

function ButtonMap:init()
    -- 4 columns, 5 rows
    self.width = 4
    self.height = 5
    self.buttons = {}
    self:createMap()
end

function ButtonMap:update(dt)

end

function ButtonMap:createMap()
    local button_value = nil
    for y = 1, self.height do
        table.insert(self.buttons, {})
        for x = 1, self.width do
            button_value = BUTTON_VALUES[y][x]
            table.insert(self.buttons[y], Button(x, y, button_value))
        end
    end
end

function ButtonMap:pointToButton(x, y)
    -- calculate x, y excel sheet of button,
    -- then return button



end

function ButtonMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.buttons[y][x]:render()
        end
    end
end
