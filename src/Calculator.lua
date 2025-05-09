Calculator = Class{}

function Calculator:init()

    -- calculator information
    self.x = CALCULATOR_X
    self.y = CALCULATOR_Y
    self.width = CALCULATOR_WIDTH
    self.height = CALCULATOR_HEIGHT
    -- calculator_screen information
    self.calScreen_x = CALSCREEN_X
    self.calScreen_y = CALSCREEN_Y
    self.calScreen_width = CALSCREEN_WIDTH
    self.calScreen_height = CALSCREEN_HEIGHT
end

function Calculator:update(dt)

end

function Calculator:render()
    -- draw calculator rectangle
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    -- draw calculator screen
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.calScreen_x, self.calScreen_y, self.calScreen_width, self.calScreen_height)
    love.graphics.setColor(1, 1, 1)
end