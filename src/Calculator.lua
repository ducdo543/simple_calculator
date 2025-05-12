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

    self.values_pressed = {}

end

function Calculator:update(dt)
    -- get button
    if love.mouse.wasPressed(1) then
        self.button = self.buttonMap:pointToButton()
        if self.button == nil then
            return
        end
        love.mouse.clicksPressed[1] = nil
        
        -- D is delete
        if self.button.value == 'D' then
            table.remove(self.values_pressed, #self.values_pressed)
            return
        end

        -- C is clear
        if self.button.value == 'C' then
            self.values_pressed = {}
            return
        end
        
        -- "=" means handle 
        if self.button.value == "=" then
            self.handle = Handle(self.values_pressed)
            return
        end

        -- add value of button_click (except D, C) into table
        table.insert(self.values_pressed, self.button.value)
        
        
        -- for i = 1, #self.values_pressed do
        --     print(self.values_pressed[i])
        -- end
    end
    self.checkValid = CheckValid(self.values_pressed)
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

    -- draw all values_pressed on screen
    love.graphics.setColor(0, 0, 0)
    for i = 1, #self.values_pressed do
        love.graphics.print(tostring(self.values_pressed[i]), CALSCREEN_X + 2 + (i - 1) * 8, CALSCREEN_Y)
    end
    love.graphics.setColor(1, 1, 1)

    -- Draw Error when checkValid False
    if self.checkValid:check() == nil then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Error", CALSCREEN_X + CALCULATOR_WIDTH - 45, CALSCREEN_Y + 6)
        love.graphics.setColor(1, 1, 1)
        return nil
    end
end


