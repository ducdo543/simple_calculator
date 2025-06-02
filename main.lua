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

    love.mouse.clicksPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.mousepressed(x, y, click)
    -- turn real mouse coordinate into virtual screen
    local virtualX, virtualY = push:toGame(x, y)

    if virtualX and virtualY then
        love.mouse.clicksPressed[click] = {
            pressed = true,
            x = virtualX,
            y = virtualY
        }
    end
end
-- create function to check if mouse was pressed
function love.mouse.wasPressed(click)
    return love.mouse.clicksPressed[click]
end

function love.update(dt)
    calculator:update(dt)

end

function love.draw()
    push:start()
    calculator:render()
    push:finish()
end


