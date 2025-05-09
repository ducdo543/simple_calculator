love.graphics.setDefaultFilter('nearest', 'nearest')
require 'src/Dependencies'

function love.load()
    love.graphics.setFont(gFonts['medium'])
    love.window.setTitle('Caculator')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    calculator = Calculator()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    calculator:update(dt)
end

function love.draw()
    push:start()
    calculator:render()
    push:finish()
end