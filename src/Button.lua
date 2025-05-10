Button = Class{}

function Button:init(x, y)
    -- x, y are in excel sheet, not real coordinate
    self.x = x
    self.y = y

    self.size = BUTTON_sIZE

    -- calculator position, but because this is a small project,
    -- and this attribute just use 1 time, so i will use global 
    self.calculator_x = CALCULATOR_X
    


    self.x_coordinate = (x - 1) * (self.size + 2) + (CALCULATOR_X + 5)
    self.y_coordinate = (y - 1) * (self.size + 2) + (CALSCREEN_HEIGHT + CALSCREEN_Y + 5)
    print(self.x_coordinate)
    print(self.y_coordinate)
end

function Button:update(dt)

end

function Button:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x_coordinate, self.y_coordinate, self.size, self.size)
    love.graphics.setColor(1, 1, 1)
end