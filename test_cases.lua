

require 'src/constants'
require 'src/ButtonMap'
require 'src/Button'

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
