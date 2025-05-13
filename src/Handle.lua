-- handle the expression when put "=" button
Handle = Class{}

function Handle:init(values_pressed)
    self.values_pressed = values_pressed
    self.copy_pressed = copy_table(self.values_pressed)

    -- group number in self.copy_pressed
    self:groupNumber()
    self.group_pressed = self.copy_pressed -- just use another name

    -- flag to check when = was pressed
    self.equal_flag = false

    -- for i = 1, #self.group_pressed do
    --     print(self.group_pressed[i])
    -- end

    self.result = copy_table(self.group_pressed) -- result is table
end

function Handle:giveResult()
    if self.equal_flag == false then
        return nil
    end
    
    local calcu_number = 0 -- after calculate one expression, retent in here 
    -- *, / first
    local i = 1
    while i <= #self.result do
        if self.result[i] == "*" or self.result[i] == "/" then
            calcu_number = OPS_PERFORM[self.result[i]](self.result[i - 1], self.result[i + 1])
            self.result[i - 1] = calcu_number
            table.remove(self.result, i + 1)
            table.remove(self.result, i)
            i = i - 1
        end
        i = i + 1
    end
    -- +, - later
    i = 0
    while i <= #self.result do
        if self.result[i] == "+" or self.result[i] == "-" then
            calcu_number = OPS_PERFORM[self.result[i]](self.result[i - 1], self.result[i + 1])
            self.result[i - 1] = calcu_number
            table.remove(self.result, i + 1)
            table.remove(self.result, i)
            i = i - 1
        end
        i = i + 1
    end


    -- for i = 1, #self.result do
    --     print(self.result[i])
    -- end
    self.result = self.result[1]
    
    -- (3, +, 45, +, 23, *, 2)
    return true
end

function Handle:checkValid()
    -- error if first place is one operator
    if OPERATORS[self.group_pressed[1]] then
        return nil
    end

    
    for i = 1, #self.group_pressed do
        if i ~= #self.group_pressed then
            -- error if two consecutive operators
            if OPERATORS[self.group_pressed[i]] and OPERATORS[self.group_pressed[i+1]] then
                return nil
            end

            -- error if after "/" is number 0
            if self.group_pressed[i] == "/" and self.group_pressed[i+1] == 0 then
                return nil
            end
        end
    end

    --when press "=" button, check remain cases
    if self.equal_flag then
        -- error if last value is operator
        if OPERATORS[self.group_pressed[#self.group_pressed]] then
            return nil
        end
    end

    return true
end

function Handle:render()
    -- Draw Error when checkValid False
    if self:checkValid() == nil then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Error", CALSCREEN_X + CALCULATOR_WIDTH - 45, CALSCREEN_Y + 6)
        love.graphics.setColor(1, 1, 1)
        return nil
    end

    -- Draw result
    if self:giveResult() then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(tostring(self.result), CALSCREEN_X + CALCULATOR_WIDTH - 30, CALSCREEN_Y + 6)
        love.graphics.setColor(1, 1, 1)        
    end
end

-- grouping discrete numbers
function Handle:groupNumber()
    -- retent number until operator (except ".") appear
    local number = 0
    local decimal_flag = false
    local counter_decimal = 0 -- number of digits after "." 
    local index_start = nil
    
    local i = 1
    while i <= #self.copy_pressed do
        if type(self.copy_pressed[i]) == "number" then
            number = number * 10 + self.copy_pressed[i] * ((1/10) ^ counter_decimal) 
            if decimal_flag then
                number = number * 1/10
            end
            if index_start == nil then
                index_start = i
            end
        elseif self.copy_pressed[i] == "." then
            decimal_flag = true
        else
            if number ~= 0 then
                self.copy_pressed[index_start] = number
                for j = i - 1, index_start + 1, - 1 do
                    table.remove(self.copy_pressed, j)
                end
                i = index_start + 1
                number = 0
                decimal_flag = false
                index_start = nil
            end
            goto continue
        end
        
        -- case when last value is number, not operator
        if i == #self.copy_pressed then
            self.copy_pressed[index_start] = number
            for j = i, index_start + 1, - 1 do
                table.remove(self.copy_pressed, j)
            end
            number = 0
            index_start = nil
        end

        ::continue::
        i = i + 1
        if decimal_flag then
            counter_decimal = counter_decimal + 1
        end

    end

        -- {4, 5, +, 6, 7} -> {45, +, 67}
end




