local HC = require "libs.HC"

isDebug = true;

playerController = require ("playerController")
backgroundController = require ("backgroundController")
meteorsController = require ("meteorsController")

function love.load(arg)
  backgroundController.load()
  playerController.load()
  meteorsController.load()
end

function love.update(dt)
  backgroundController.update(dt)
  playerController.update(dt)
  meteorsController.update(dt)
end

function love.draw()
  backgroundController.draw()
  playerController.draw()
  meteorsController.draw()
  love.graphics.print(string.format("Press 'p' key to enter HC debug mode (currently set to: %s)", isDebug))
end

function love.keypressed(key, scancode, isrepeat)
  -- se è premuto 'escape' chiude uil gioco
  if(key == "escape") then
    love.event.push('quit')
  end

  -- se è premuto space, spara un proiettile
  if(key == "space") then
    playerController.fireBullet()
  end

  if(key == "p") then
    isDebug = not isDebug
    playerController.isDebug = isDebug
    meteorsController.isDebug = isDebug
  end

end
