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

    -- test buttonmap
    self.buttonMap = ButtonMap()

    -- button that click
    self.button = nil
end

function Calculator:update(dt)
-- add value of button_click into table
    if love.mouse.wasPressed(1) then
        self.button = self.buttonMap:pointToButton()
        if self.button == nil then
            return
        end
        print(self.button.value)
        love.mouse.clicksPressed[1] = nil
    end
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

    self.buttonMap:render()
end


