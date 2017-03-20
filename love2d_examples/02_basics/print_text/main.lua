function love.load(arg)
    visitorFont = love.graphics.newFont("assets/fonts/visitor/visitor1.ttf", 30)
    deltaTime = 0
end

function love.update(dt)
  deltaTime = dt
end

function love.draw()
  love.graphics.setFont(visitorFont)
  love.graphics.printf("Delta time " .. deltaTime, 30, 30, love.graphics.getWidth(), "left")
  local fps = love.timer.getFPS()
  love.graphics.printf("FPS " .. fps, 30, 70, love.graphics.getWidth(), "left")
end
