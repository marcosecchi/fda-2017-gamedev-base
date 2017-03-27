--[[
  Questo esempio mostra l'utilizzo dei modulo in Lua
]]

player = require ("lib/player") -- carica il modulo

function love.load(arg)
   -- carico l'immagine, recuperando il path dal modulo
  player.img = love.graphics.newImage(player.sprite)
  -- definisco le immagini dello sprite, recuperandole dall'immagine caricata
  player.width = player.img:getWidth()
  player.height = player.img:getHeight()
  -- definisco la posizione di partenza dello sprite
  player.posX = love.graphics.getWidth() / 2
  player.posY = love.graphics.getHeight() - 80
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(player.img, player.posX, player.posY, 0, 1, 1, player.width / 2, player.height / 2)
end
