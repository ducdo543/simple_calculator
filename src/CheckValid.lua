-- more like a function because it has one method return boolean,
-- use class because familiar and take advantage of self

CheckValid = Class{}

function CheckValid:init(values_pressed)
    self.values_pressed = values_pressed
end

function CheckValid:check()
    -- error if first place is one operator
    if OPERATORS[self.values_pressed[1]] then
        return nil
    end
    return true
end