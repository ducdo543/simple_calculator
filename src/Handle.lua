-- handle the expression when put "=" button
Handle = Class{}

function Handle:init(values_pressed, equal_flag)
    self.values_pressed = values_pressed
    self.copy_pressed = copy_table(self.values_pressed)

    -- group number in self.copy_pressed
    self.group_pressed = copy_table(self.copy_pressed)
    self:groupNumber()

    -- flag to check when = was pressed
    self.equal_flag = equal_flag or false

    -- for i = 1, #self.group_pressed do
    --     print(self.group_pressed[i])
    -- end

    self.results = copy_table(self.group_pressed) -- results is table
    self.result = nil
    self.checkValid_flag = self:checkValid()
    if self.checkValid_flag ~= nil then
        self.giveResult_flag = self:giveResult()
    end

end

function Handle:giveResult(index_start)
    if self.equal_flag == false then
        return nil
    end
    
    local calcu_number = 0 -- after calculate one expression, retent in here 
    local sign_integer = 1

    -- encounter "(" right after number or encouter "(" right after ")"
    local i = index_start or 1
    while i <= #self.results do
        if i > 1 and self.results[i] == "(" then
            if type(self.results[i - 1]) == "number" or self.results[i - 1] == ")" then
                table.insert(self.results, i, "*")
                i = i + 1
            end
        end
        i = i + 1
    end
    
    -- *, / 
    i = index_start or 1
    while i <= #self.results do
        if i ~= #self.results and self.results[i + 1] == "(" then
            self:giveResult(i + 1)
        end
        if self.results[i] == "*" or self.results[i] == "/" then

            local j = i + 1
            while j <= #self.results do -- if after is + or -, change sign nega posi for sign_integer, and remove sign + and -
                if self.results[j] == "-" then
                    sign_integer = sign_integer * (-1)
                end
                if self.results[j] == "-" or self.results[j] == "+" then
                    table.remove(self.results, j)
                    j = j - 1
                end
                if type(self.results[j]) == "number" then
                    break
                end
                if self.results[j] == "(" then
                    self:giveResult(j)
                    j = j - 1
                end
                j = j + 1
            end
            calcu_number = OPS_PERFORM[self.results[i]](self.results[i - 1], self.results[i + 1] * sign_integer)
            sign_integer = 1
            
            self.results[i - 1] = calcu_number
            table.remove(self.results, i + 1)
            table.remove(self.results, i)
            i = i - 1
        end
        if self.results[i] == ")" then
            break
        end
        i = i + 1
    end
    -- +, - later
    i = index_start or 1
    sign_integer = 1
    while i <= #self.results do
        if i ~= #self.results and self.results[i + 1] == "(" then
            self:giveResult(i + 1)
        end
        if self.results[i] == "+" or self.results[i] == "-" then

            local j = i + 1
            while j <= #self.results do -- if after is + or -, change sign nega posi for sign_integer, and remove sign + and -
                if self.results[j] == "-" then
                    sign_integer = sign_integer * (-1)
                end
                if self.results[j] == "-" or self.results[j] == "+" then
                    table.remove(self.results, j)
                    j = j - 1
                end
                if type(self.results[j]) == "number" then
                    break
                end
                if self.results[j] == "(" then
                    self:giveResult(j)
                    j = j - 1
                end
                j = j + 1
            end
            calcu_number = OPS_PERFORM[self.results[i]](self.results[i - 1], self.results[i + 1] * sign_integer)
            sign_integer = 1

            self.results[i - 1] = calcu_number
            table.remove(self.results, i + 1)
            table.remove(self.results, i)
            i = i - 1
        end
        if self.results[i] == ")" then
            break
        end
        i = i + 1
    end


    -- (6)
    -- for i = 1, #self.results do -- index_start instead 1
    --     if self.results[i] == ")" then
    --         table.remove(self.results, i)
    --         table.remove(self.results, i - 2)
    --     end
    -- end

    i = index_start or 1
    -- (6), remove parenthesis
    if self.results[i + 2] == ")" then -- index_start instead 1
        table.remove(self.results, i + 2)
        table.remove(self.results, i)
    end
    -- (6 , remove parenthesis
    if self.results[i] == "(" then
        table.remove(self.results, i)
        -- if i > 1 and not OPERATORS[self.results[i - 1]] then
        --     self.results[i] = "*"
        -- else
        --     table.remove(self.results, i)
        -- end
    end
    
    -- 6
    
    -- for i = 1, #self.results do
    --     print(self.results[i])
    -- end
    if #self.results == 1 then
        self.result = self.results[1]
        return true
    end

    -- (3, +, 45, +, 23, *, 2)
end

function Handle:checkValid()
    -- error if first place is ".", "*", "/" 
    if self.copy_pressed[1] == "." or self.copy_pressed[1] == "*" or self.copy_pressed[1] == "/" then
        return nil
    end

    local balance = 0 --balance = number of "(" subtract number of ")"
    for i = 1, #self.copy_pressed do
        if i ~= #self.copy_pressed then
            -- after operator is + or - still ok

            -- error if after operator is * and / and "."
            if OPERATORS[self.copy_pressed[i]] then
                if self.copy_pressed[i + 1] == "*" or self.copy_pressed[i + 1] == "/" or self.copy_pressed[i + 1] == "." then
                    return nil
                end
            end
            -- error if after "." is + and -
            if self.copy_pressed[i] == "." then
                if self.copy_pressed[i + 1] == "+" or self.copy_pressed[i + 1] == "-" then
                    return nil
                end
            end
            

            -- error if after "/" is number 0
            if self.copy_pressed[i] == "/" and self.copy_pressed[i+1] == 0 then
                return nil
            end

            -- error if after "." is another dot, actually it should be one another operator in beween two dot, 8.8.8 is wrong for ex
            if self.copy_pressed[i] == "." then
                local find_dot = false
                for j = i + 1, #self.copy_pressed do
                    if type(self.copy_pressed[j]) == "number" then
                        goto continue
                    elseif OPERATORS[self.copy_pressed[j]] and self.copy_pressed[j] ~= "." then
                        break
                    elseif self.copy_pressed[j] == "." then
                        find_dot = true
                    end
                    ::continue::
                end
                if find_dot == true then
                    return nil
                end
            end

            -- error if after "(" is ".", "*", "/" 
            if self.copy_pressed[i] == "(" then
                if self.copy_pressed[i+1] == "." or self.copy_pressed[i+1] == "*" or self.copy_pressed[i+1] == "/" then
                    return nil
                end
            end
            -- error if after "(" is ")", means that error if no number in between
            if self.copy_pressed[i] == "(" then
                if self.copy_pressed[i+1] == ")" then
                    return nil
                end
            end
            -- error if after ")" is number
            if self.copy_pressed[i] == ")" then
                if type(self.copy_pressed[i+1]) == "number" then
                    return nil
                end
            end
        end
        -- error if before ")" is operator
        if i ~= 1 then
            if self.copy_pressed[i] == ")" then
                if OPERATORS[self.copy_pressed[i-1]] then
                    return nil
                end
            end
        end
        -- error if balance < 0
        if self.copy_pressed[i] == "(" then
            balance = balance + 1
        end
        if self.copy_pressed[i] == ")" then
            balance = balance - 1
        end
        if balance < 0 then
            return nil
        end
    end

    
    

    --when press "=" button, check remain cases
    if self.equal_flag then
        -- error if last value is operator
        if OPERATORS[self.group_pressed[#self.group_pressed]] then
            return nil
        end
        -- error if last value is "("
        if self.group_pressed[#self.group_pressed] == "(" then
            return nil
        end
    end

    return true
end

function Handle:render()
    -- Draw Error when checkValid False
    if self.checkValid_flag == nil then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Error", CALSCREEN_X + CALCULATOR_WIDTH - 45, CALSCREEN_Y + 6)
        love.graphics.setColor(1, 1, 1)
        return nil
    end

    -- Draw result
    if self.giveResult_flag then
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
    while i <= #self.group_pressed do
        if type(self.group_pressed[i]) == "number" then
            number = number * 10 + self.group_pressed[i] * ((1/10) ^ counter_decimal) 
            if decimal_flag then
                number = number * 1/10
                counter_decimal = counter_decimal + 1
            end
            if index_start == nil then
                index_start = i
            end
        elseif self.group_pressed[i] == "." then
            decimal_flag = true
        else
            if number ~= 0 then
                self.group_pressed[index_start] = number
                for j = i - 1, index_start + 1, - 1 do
                    table.remove(self.group_pressed, j)
                end
                i = index_start + 1
                number = 0
                decimal_flag = false
                index_start = nil
                counter_decimal = 0
            end
        end
        
        -- case when last value is number, not operator
        if i == #self.group_pressed and type(self.group_pressed[i]) == "number" then
            self.group_pressed[index_start] = number
            for j = i, index_start + 1, - 1 do
                table.remove(self.group_pressed, j)
            end
            number = 0
            index_start = nil
            counter_decimal = 0
        end

        i = i + 1

    end
        -- {4, 5, +, 6, 7} -> {45, +, 67}
    
    -- insert 0 if - or + in the first place of self.group_pressed
    if self.group_pressed[1] == "+" or self.group_pressed[1] == "-" then
        table.insert(self.group_pressed, 1, 0)
    end
    -- insert 0 if - or + is right after "("
    i = 0
    while i <= #self.group_pressed do
        if i ~= #self.group_pressed and self.group_pressed[i] == "(" then
            if self.group_pressed[i + 1] == "+" or self.group_pressed[i + 1] == "-" then
                table.insert(self.group_pressed, i + 1, 0)
                i = i + 2
            end
        end
        i = i + 1
    end
end




