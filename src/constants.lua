Class = require 'lib/class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144 

CALCULATOR_WIDTH = 80
CALCULATOR_HEIGHT = 120

-- calculator position: 88, 12
CALCULATOR_X = (VIRTUAL_WIDTH - CALCULATOR_WIDTH) / 2
CALCULATOR_Y = (VIRTUAL_HEIGHT - CALCULATOR_HEIGHT) / 2


CALSCREEN_WIDTH = 70
CALSCREEN_HEIGHT = 20

-- 93, 17
CALSCREEN_X = (CALCULATOR_WIDTH - CALSCREEN_WIDTH) / 2 + CALCULATOR_X
CALSCREEN_Y = CALCULATOR_Y + 5

-- the distance between buttons is 2, 
-- between button and margin side is 5
-- each row has 4 buttons, so:
BUTTON_SIZE = 16


BUTTON_VALUES = {
    {'(', ')', 'D', 'C'},
    {7, 8, 9, '+'},
    {4, 5, 6, '-'},
    {1, 2, 3, '*'},
    {0, '.', '=', '/'}
}

OPERATORS = {
    ['+'] = true,
    ['-'] = true,
    ['*'] = true,
    ['/'] = true,
    ['='] = true,
    ['.'] = true
}


function add(x, y)
    return x + y 
end

function subtract(x, y)
    return x - y 
end

function multiply(x, y)
    return x * y 
end 

function divide(x, y)
    return x / y 
end

OPS_PERFORM = {
    ["+"] = add,
    ["-"] = subtract,
    ["*"] = multiply,
    ["/"] = divide
}