local sodapop = require 'libs.sodapop'

function love.load(arg)
  bg = love.graphics.newImage("assets/bg.png")
  skeletonSpritesheet = love.graphics.newImage("assets/skeleton.png")
  posX, posY = 0, 0
  speed = 1

  -- definisco i parametri dello stencil
  stencilMaxSize = 200 -- dimensione massima
  stencilSize = 200    -- dimensione da renderizzare
  fadeDirection = -1   -- direzione (in/out)
  fadeSpeed = 150      -- velocità rispetto al deltatime
  showStencil = true

  -- instanzia uno sprite animato con sodapop
  skeleton = sodapop.newAnimatedSprite()

  -- definisce le animazioni
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
    skeleton:goToFrame(8)
  end

  if(nextX >= 32 and nextX <= love.graphics.getWidth() - 32) then
    skeleton.x = nextX
  end
  if(nextY >= 32 and nextY <= love.graphics.getHeight() - 32) then
    skeleton.y = nextY
  end
  skeleton:update(dt)

  -- se lo stencil non va mostrato ritorna la funzione perché non c'è più nulla da calcolare
  if not showStencil then return end

  -- calcolo se lo stencil si è chiuso completamente oppure è arrivato al massimo dell'apertura
  -- in caso affermativo, inverto la direzione
  if stencilSize < 0 or stencilSize > stencilMaxSize then
    fadeDirection = -fadeDirection
  end
  -- calcolo la dimensione
  stencilSize = stencilSize + fadeSpeed * fadeDirection * dt
end

function love.keypressed(key, scancode, isrepeat)
  -- effettua un toggle per mostrare/nascondere lo stencil
  if(key == "p") then
    showStencil = not showStencil
    stencilSize = stencilMaxSize
  end
end

-- funzione che 'disegna lo stencil'
local function circleStencilFunction()
   love.graphics.circle("fill", skeleton.x, skeleton.y, stencilSize, 50)
end

function love.draw()

  -- se lo stencil va mostrato, lo disegna a schermo
  if showStencil then
    love.graphics.stencil(circleStencilFunction, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
  end

  love.graphics.draw(bg)
  skeleton:draw()

  -- chiude la fase di disegno dello stencil
  if showStencil then
    love.graphics.setStencilTest()
  end

  love.graphics.print("Press 'p' to toggle stencil", 10, 10)
end
