function love.load(arg)

  -- init fonts
  font20 = love.graphics.newFont("fonts/visitor/visitor1.ttf", 20)

  -- init audio
  beep = love.audio.newSource("audio/beep.wav", "static")

  gravity = 0.4

  floor = {
    y = love.graphics.getHeight() - 100,
    r = 100,
    g = 100,
    b = 100,
    a = 255
  }

  sky = {
    r = 190,
    g = 190,
    b = 190,
    a = 190
  }

  player = {
    size = 20,
    x = love.graphics.getWidth() / 2,
    y = floor.y,
    velX = 0,
    velY = 0,
    acc = 2,
    dec = 0.4,
    maxVel = 10,
    r = 60,
    g = 60,
    b = 60,
    a = 255,
    isJumping = false,
    jump = -10
  }
end

function love.update(dt)
  if (love.keyboard.isDown("left")) then
    -- move left
    player.velX = player.velX - player.acc
  elseif(love.keyboard.isDown("right")) then
    -- move right
    player.velX = player.velX + player.acc
  elseif(player.velX > 0) then
    player.velX = player.velX - player.dec
  elseif(player.velX < 0) then
    player.velX = player.velX + player.dec
  end

  if(
    player.velX < 0.3 and
    player.velX > -0.3
  ) then
    player.velX = 0
  end
  -- horizontal movement
  if (player.x < player.size / 2 - player.velX) then
    player.velX = 0
    player.x = player.size / 2 - player.velX
  elseif (player.x > love.graphics.getWidth() - player.velX - player.size / 2) then
    player.velX = 0
    player.x = love.graphics.getWidth() - player.velX - player.size / 2
  else
    if(player.velX > player.maxVel) then
      player.velX = player.maxVel
    elseif((player.velX < -player.maxVel)) then
      player.velX = -player.maxVel
    end
    player.x = player.x + player.velX
  end

  -- vertical movement
  if (player.y + player.velY > floor.y) then
    player.velY = 0
    player.isJumping = false

    if(
      player.velY < 0.5 and
      player.velY > -0.5
    ) then
      player.velY = 0
    end
  else
    player.y = player.y + player.velY
  end

  -- add gravity
  player.velY = player.velY + gravity

end

function love.keypressed(key, scancode, isrepeat)
  if (key == "space" and player.isJumping == false) then
    player.isJumping = true
    player.velY = player.jump
    beep:play()
  elseif (key == "1") then
    gravity = 0.4
  elseif (key == "2") then
    gravity = 0.6
  elseif (key == "3") then
    gravity = 0.9
  end
end

function love.draw()
  -- draw sky
  love.graphics.setColor(sky.r, sky.g, sky.b, sky.a)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- draw floor
  love.graphics.setColor(floor.r, floor.g, floor.b, floor.a)
  love.graphics.rectangle("fill", 0, floor.y, love.graphics.getWidth(), love.graphics.getHeight())

  -- draw player
  love.graphics.setColor(player.r, player.g, player.b, player.a)
  love.graphics.rectangle("fill", player.x - player.size / 2, player.y - player.size , player.size, player.size)

  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(font20)
  love.graphics.printf("press 'Space' to jump", 0, love.graphics.getHeight() - 80, love.graphics.getWidth(), "center")
  love.graphics.printf("press 'left/right' arrows to move", 0, love.graphics.getHeight() - 60, love.graphics.getWidth(), "center")
  love.graphics.printf("press '1', '2', '3' to change gravity", 0, love.graphics.getHeight() - 40, love.graphics.getWidth(), "center")

  love.graphics.printf("gravity: " .. gravity, 10, 10, 200, "left")

end
