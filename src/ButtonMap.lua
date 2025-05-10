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

function ButtonMap:pointToButton()
    -- calculate x, y excel sheet of button,
    -- then return button

    -- virtual mouse coordinate
    local X = love.mouse.clicksPressed[1]['x']
    local Y = love.mouse.clicksPressed[1]['y']

    -- the place where we start draw button
    local firstButton_x = CALSCREEN_X
    local firstButton_y = CALSCREEN_Y + CALSCREEN_HEIGHT + 5

    -- x, y excel sheet of button that contains mouse click
    local x = math.floor((X - firstButton_x)/(BUTTON_SIZE + 2) + 1)
    local y = math.floor((Y - firstButton_y)/(BUTTON_SIZE + 2) + 1) 

    -- eliminate cases that click outside button map
    if x < 1 or x > 4 or y < 1 or y > 5 then
        return nil
    end
    -- eliminate cases that click in edges between buttons
    if X > ((x - 1) * 2 + x * BUTTON_SIZE) + firstButton_x then
        return nil
    end
    if Y > ((y - 1) * 2 + y * BUTTON_SIZE) + firstButton_y then
        return nil
    end

    return self.buttons[y][x]

end

function ButtonMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.buttons[y][x]:render()
        end
    end
end
