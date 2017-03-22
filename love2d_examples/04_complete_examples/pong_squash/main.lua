function love.load(arg)
  font40 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 40)
  font20 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 20)
  beep = love.audio.newSource("audio/beep.wav", "static")
  beep2 = love.audio.newSource("audio/beep2.wav", "static")

  score = 0

  padY = love.graphics.getHeight() / 2
  ballX = love.graphics.getWidth() - 50
  ballY = love.graphics.getHeight() / 2
  ballDx = -1
  ballDy = 1
end

function love.update(dt)

  -- pad movement
    if(love.keyboard.isDown("up")) then
      padY = padY - 3
    elseif(love.keyboard.isDown("down")) then
      padY = padY + 3
    end

    if(padY < 10) then
      padY = 10
    elseif(padY > love.graphics.getHeight() - 70) then
      padY = love.graphics.getHeight() - 70
    end

    ballX =  (ballX + ballDx * 3)
    ballY = (ballY + ballDy * 3)

    if(ballY > love.graphics.getHeight() - 20) then
      ballY = love.graphics.getHeight() - 20
      ballDy = -ballDy
      beep:play()
    elseif (ballY < 10) then
      ballY = 10
      ballDy = -ballDy
      beep:play()
    end

    if(ballX < 110) then
      ballDx = -ballDx
      beep:play()
    end

    if(
      ballX > love.graphics.getWidth() - 40 and
      ballY >= padY and
      ballY <= (padY + 50)
    ) then
      ballDx = -ballDx
      beep:play()
      score = score + 1
    end

    if(ballX > love.graphics.getWidth()) then
      score = 0
      ballX = love.graphics.getWidth() - 50
      ballY = love.graphics.getHeight() / 2
      ballDx = -1
      ballDy = 1
      beep2:play()
    end
end

function love.draw()
  -- draw board
  love.graphics.rectangle("fill", 100, 0, love.graphics.getWidth() - 100, 10)
  love.graphics.rectangle("fill", 100, love.graphics.getHeight() - 10, love.graphics.getWidth() - 100, 10)
  love.graphics.rectangle("fill", 100, 0, 10, love.graphics.getHeight())

  -- draw pad
  love.graphics.rectangle("fill", love.graphics.getWidth() - 30, padY, 10, 60)

  -- draw ball
  love.graphics.rectangle("fill", ballX, ballY, 10, 10)

  -- draw score
  love.graphics.setFont(font40)
  love.graphics.printf(score, 0, 40, 100, "center")
  love.graphics.setFont(font20)
  love.graphics.printf("FPS: " .. love.timer.getFPS(), 14, love.graphics.getHeight() - 30, 100, "left")
  love.graphics.printf("score", 0, 20, 100, "center")

end
