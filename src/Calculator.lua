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

    -- still can call method for self.handle if self.handle == nil,
    -- (but never happen in this project)
    self.special_handle = {
        checkValid = function() return true end,
        groupNumber = function() end,
        render = function() end
    }

    self.equal_flag = false
end

function Calculator:update(dt)
    -- create self.handle
    if self.values_pressed ~= nil then -- this project always has self.values_pressed ~= nil
        self.handle = Handle(self.values_pressed)
    else
        self.handle = self.special_handle
    end
    self.handle.equal_flag = self.equal_flag

    -- get button
    if love.mouse.wasPressed(1) then
        self.button = self.buttonMap:pointToButton()
        if self.button == nil then
            return
        end
        love.mouse.clicksPressed[1] = nil
        
        -- "=" means turn on equal_flag
        if self.button.value == "=" then
            self.equal_flag = true
            return
        else
            self.equal_flag = false
        end

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


        -- add value of button_click (except D, C) into table
        table.insert(self.values_pressed, self.button.value)
        

        -- for i = 1, #self.values_pressed do
        --     print(self.values_pressed[i])
        -- end
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

    -- draw all values_pressed on screen
    love.graphics.setColor(0, 0, 0)
    for i = 1, #self.values_pressed do
        love.graphics.print(tostring(self.values_pressed[i]), CALSCREEN_X + 2 + (i - 1) * 8, CALSCREEN_Y)
    end
    love.graphics.setColor(1, 1, 1)

    -- draw error or result
    self.handle:render()

end


