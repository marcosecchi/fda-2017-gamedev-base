local HC = require "libs.HC"

isDebug = true;

player = require ("player")
background = require ("background")
meteors = require ("meteors")

function love.load(arg)
  background.load()
  player.load()
end

function love.update(dt)
  background.update(dt)
  player.update(dt)
end

function love.draw()
  background.draw()
  player.draw()
  love.graphics.print(string.format("Press 'p' key to enter HC debug mode (currently set to: %s)", isDebug))
end

function love.keypressed(key, scancode, isrepeat)
  -- se è premuto 'escape' chiude uil gioco
  if(key == "escape") then
    love.event.push('quit')
  end

  -- se è premuto space, spara un proiettile
  if(key == "space") then
    player.fireBullet()
  end

  if(key == "p") then
    isDebug = not isDebug
    player.isDebug = isDebug
  end

end
