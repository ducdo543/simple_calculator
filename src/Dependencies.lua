Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/Calculator'
require 'src/Button'
require 'src/ButtonMap'
require 'src/Handle'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('fonts/fipps.otf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}

