player = require ("player")
background = require ("background")

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

  -- attiva/disattiva i vari proiettili
  if(key == "1") then
    player.toggleSingleBullet()
  elseif(key == "2") then
    player.toggleDoubleBullet()
  elseif(key == "3") then
    player.toggleBigBullet()
  end

end
