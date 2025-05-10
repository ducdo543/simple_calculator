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
    for y = 1, self.height do
        table.insert(self.buttons, {})
        for x = 1, self.width do
            table.insert(self.buttons[y], Button(x, y))
        end
    end
end

function ButtonMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.buttons[y][x]:render()
        end
    end
end