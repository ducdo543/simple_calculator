

require 'src/constants'
require 'src/ButtonMap'
require 'src/Button'
require 'src/Handle'

describe('ButtonMap', function()
    local map

    before_each(function()
        map = ButtonMap()
    end)
    it('create buttons grid', function()
        assert.are.equal(5, #map.buttons) -- 5 rows
        
        assert.are.equal(7, map.buttons[2][1].value) -- y =2, x=1 in sheet buttons is 7
        assert.are.equal("(", map.buttons[1][1].value) -- y = 1, x=1 in sheet buttons is "("
    end)
end)

-- create Calculator again to not use love game engine
describe('Calculator', function()
    local Calculator

    before_each(function()
        Calculator = Class{}
        
        function Calculator:init()
            self.values_pressed = {}
        end
    
        function Calculator:update(dt)
            if self.fake_button == "=" then
                return
            end

            -- D is delete
            if self.fake_button == 'D' then
                table.remove(self.values_pressed, #self.values_pressed)
                return
            end

            -- C is clear
            if self.fake_button == 'C' then
                self.values_pressed = {}
                return
            end


            -- add value of button_click (except D, C) into table
            table.insert(self.values_pressed, self.fake_button)
        end
    end)

    it("create fake_button into self.values_pressed", function()
        local calculator = Calculator()
        calculator.fake_button = 5
        calculator:update(0)
        calculator.fake_button = "."
        calculator:update(0)
        calculator.fake_button = 6
        calculator:update(0)
        calculator.fake_button = "+"
        calculator:update(0)
        calculator.fake_button = 7
        calculator:update(0)
    
        assert.are.same({5, ".", 6, "+", 7}, calculator.values_pressed)
    end)
end)

describe('Handle', function()
    local handle

    it("check group_pressed", function()
        handle = Handle({5, ".", 6, "+", 7})

        assert.are.same({5.6, "+", 7}, handle.group_pressed)
    end)
end)

