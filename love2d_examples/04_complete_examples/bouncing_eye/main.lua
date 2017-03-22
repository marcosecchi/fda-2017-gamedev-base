function love.load(arg)
  -- init fonts
  font20 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 20)

  -- init audio
  beep = love.audio.newSource("audio/beep.wav", "static")
  beep2 = love.audio.newSource("audio/beep2.wav", "static")

  size  = 20
  ballX = 100
  ballY = 100
  floorY = 100

  -- starting velocity
  velX = math.random(-3, 3)
  velY = math.random(-3, 3)
end

function love.update(dt)
  -- move ball left/right
  if (
    ballX + velX < 0 + size or
    ballX + velX > love.graphics.getWidth() - size
  ) then
    -- bouncing on side
    velX = velX * -1
    beep:play()
  else
    ballX = ballX + velX
  end

  -- move ball up/down
  if (
    ballY + velY < 0 + size or
    ballY + velY > love.graphics.getHeight() - floorY - size
  ) then
    -- bounce on floor/ceiling
    velY = velY * -0.9
    beep:play()

    -- if bounce was too small,
    -- bump into air
    if(
      velY < 0.7 and
      velY > -0.7
    ) then
      velX = math.random(-3, 3)
      velY = math.random(-10, -4)
      beep2:play()
    end

  else
    ballY = ballY + velY
  end

  -- add gravity
  velY = velY + 0.4
end

function love.keypressed(key, scancode, isrepeat)
  -- press spacebar to ranomly bump the ball
  if (key == "space") then
    velX = math.random(-3, 3)
    velY = math.random(-8, -2)
    beep2:play()
  end

end

function love.draw()
  -- draw floor
  love.graphics.setColor(150, 150, 150, 255)
  love.graphics.rectangle("fill", 0, love.graphics.getHeight() - floorY, love.graphics.getWidth(), floorY)

  -- draw help text
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(font20)
  love.graphics.printf("press 'Space' to bump", 0, love.graphics.getHeight() - 60, love.graphics.getWidth(), "center")

  -- draw ball
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.circle("fill", ballX, ballY, size, 20)

  -- draw inner ball
  love.graphics.setColor(20, 120, 240, 255)
  love.graphics.circle("fill", ballX - velX, ballY - velY, size / 2, 10)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.circle("fill", ballX - velX, ballY - velY, size / 4, 10)
  love.graphics.setColor(255, 255, 255, 255)
end
