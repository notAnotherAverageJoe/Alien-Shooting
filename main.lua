function love.load()
    love.mouse.setVisible(false)

    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1
    missedShots = 0

    gameFont = love.graphics.newFont(40)
    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky3.png')

    sprites.target = love.graphics.newImage('sprites/aliens.png')
    sprites.crosshairs = love.graphics.newImage('sprites/ch.png')
    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.sky, 0, 0)
    -- sets this section to black
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5, 5)
    love.graphics.print("Misses: " .. missedShots, 500, 5)
    love.graphics.print("Time: " .. math.ceil(timer), 300, 0)
    -- setting it back to white
    love.graphics.setColor(1, 1, 1)

    if gameState == 1 then
        love.graphics.printf("Click anyhwere to begin!", 0, 250, love.graphics.getWidth(), "center")
    end
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
        love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
    end
end

function love.mousepressed(x, y, button, istough, presses)
    if button == 1 and gameState == 2 then -- x / y is current mouse and then the target location is set above
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif mouseToTarget > target.radius then
            missedShots = missedShots + 1
            if score > 0 then
            score = score - 1
            else score =0
            end
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
        missedShots = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
