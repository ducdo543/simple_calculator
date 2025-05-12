-- handle the expression when put "=" button
Handle = Class{}

function Handle:init(values_pressed)
    self.copy_pressed = copy_table(values_pressed)

    -- group number in self.copy_pressed
    self:groupNumber()
    self.group_pressed = self.copy_pressed -- just use another name

    for i = 1, #self.group_pressed do
        print(self.group_pressed[i])
    end


end

-- grouping discrete numbers
function Handle:groupNumber()
    -- retent number until operator appear
    local number = 0
    local index_start = nil
    
    local i = 1
    while i <= #self.copy_pressed do
        if type(self.copy_pressed[i]) == "number" then
            number = number * 10 + self.copy_pressed[i]
            if index_start == nil then
                index_start = i
            end
        else
            if number ~= 0 then
                self.copy_pressed[index_start] = number
                for j = i - 1, index_start + 1, - 1 do
                    table.remove(self.copy_pressed, j)
                end
                i = index_start + 1
                number = 0
                index_start = nil
            end
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

        i = i + 1

    end

        -- {4, 5, +, 6, 7} -> {45, +, 67}
end




