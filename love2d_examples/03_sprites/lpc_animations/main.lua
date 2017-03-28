local sodapop = require 'sodapop'

function love.load(arg)
  skeletonSpritesheet = love.graphics.newImage("skeleton.png")
  posX, posY = 0, 0
  speed = 1

  skeleton = sodapop.newAnimatedSprite()

  -- definisco le verie animazioni
  skeleton:addAnimation('walk-right', {
    image = skeletonSpritesheet, -- spritesheet da cui prendere le immagini
    frameWidth = 64,             -- larghezza di uno sprite
    frameHeight = 64,            -- altezza di uno sprite
    frames = {                   -- definizione dei frame e della loro durata
      {2, 12, 9, 12, .1}
    }
  })
  skeleton:addAnimation('walk-left', {
    image = skeletonSpritesheet,
    frameWidth = 64,
    frameHeight = 64,
    frames = {
      {2, 10, 9, 10, .1}
    }
  })
  skeleton:addAnimation('walk-up', {
    image = skeletonSpritesheet,
    frameWidth = 64,
    frameHeight = 64,
    frames = {
      {2, 9, 9, 9, .1}
    }
  })
  skeleton:addAnimation('walk-down', {
    image = skeletonSpritesheet,
    frameWidth = 64,
    frameHeight = 64,
    frames = {
      {2, 11, 9, 11, .1}
    }
  })

  skeleton.x, skeleton.y = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
end

function love.update(dt)
  nextX, nextY = skeleton.x, skeleton.y
  -- le condizioni si trovano tutte in un unico controllo
  -- perché non abbiamo un movimento diagonale
  if(love.keyboard.isDown("up")) then
    skeleton:switch('walk-up', true)
    nextY = nextY - speed
  elseif (love.keyboard.isDown("down")) then
    skeleton:switch('walk-down', true)
    nextY = nextY + speed
  elseif (love.keyboard.isDown("left")) then
    skeleton:switch('walk-left', true)
    nextX = nextX - speed
  elseif (love.keyboard.isDown("right")) then
    skeleton:switch('walk-right', true)
    nextX = nextX + speed
  else
    skeleton:goToFrame(1)
  end

  if(nextX >= 32 and nextX <= love.graphics.getWidth() - 32) then
    skeleton.x = nextX
  end
  if(nextY >= 32 and nextY <= love.graphics.getHeight() - 32) then
    skeleton.y = nextY
  end
  skeleton:update(dt)
end

function love.draw()
  skeleton:draw() -- disegno il personaggio con il pivot al suo centro
end
