local HC = require "libs.HC"

isDebug = true;
isPaused = false

playerController = require ("playerController")
backgroundController = require ("backgroundController")
meteorsController = require ("meteorsController")

function love.load(arg)
  backgroundController.load()
  playerController.load()
  meteorsController.load()
end

function love.update(dt)
  if isPaused then return end

  backgroundController.update(dt)
  playerController.update(dt)
  meteorsController.update(dt)

  -- se non esistono più meteoriti nella lista, rigenerali
  if meteorsController.getNumMeteors() == 0 then
    meteorsController.generateMeteors()
  end
end

function love.draw()
  backgroundController.draw()
  playerController.draw()
  meteorsController.draw()
  love.graphics.print(string.format("Press 'd' key to enter HC debug mode (currently set to: %s)", isDebug), 10, 10)
  love.graphics.print("Press 'p' key to pause", 10, 30)
end

function love.keypressed(key, scancode, isrepeat)
  -- se è premuto 'escape' chiude il gioco
  if(key == "escape") then
    love.event.push('quit')
  end

  if(key == "p") then
    isPaused = not isPaused
  end

  if(key == "space" and playerController.status == "game over") then
    playerController.status = "play"
  elseif(key == "space") then
    playerController.fireBullet()
  end

  if(key == "d") then
    isDebug = not isDebug
    playerController.isDebug = isDebug
    meteorsController.isDebug = isDebug
  end

end
