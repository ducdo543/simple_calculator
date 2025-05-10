Button = Class{}

function Button:init(x, y, value)
    -- x, y are in excel sheet, not real coordinate
    self.x = x
    self.y = y

    self.size = BUTTON_SIZE

    self.value = value


    -- calculator position, but because this is a small project,
    -- and this attribute just use 1 time, so i will use global 
    self.calculator_x = CALCULATOR_X
    

    self.x_coordinate = (x - 1) * (self.size + 2) + (CALCULATOR_X + 5)
    self.y_coordinate = (y - 1) * (self.size + 2) + (CALSCREEN_HEIGHT + CALSCREEN_Y + 5)

end

function Button:update(dt)

end

function Button:render()
    -- draw square button
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x_coordinate, self.y_coordinate, self.size, self.size)
    love.graphics.setColor(1, 1, 1)
    -- draw value for button
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(gFonts['small'])
    --try to center value in the button by hand for faster
    love.graphics.print(tostring(self.value), (self.x_coordinate + self.size/2 - 4), (self.y_coordinate - 4) + (self.size/2 - 4))
end