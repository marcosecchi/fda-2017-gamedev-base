local HC = require "libs.HC"
local meteors = require ("meteors")

--[[
  *** VARIABILI LOCALI ***
]]

local player = {}

local sprite = "assets/player.png"
local bulletSprite = "assets/laser01.png"
local bulletAudioSource = "assets/laser01.wav"

local bullets = {} -- tabella che conterrà i dati dei proiettili

player.x = 0
player.y = 0
player.img = nil
player.velX = 0
player.velY = 0
player.acc = 2
player.dec = 0.4
player.maxVel = 8
player.isDebug = true

--[[
  *** FUNZIONI LOCALI ***
]]

local function createBullet()
  local img = love.graphics.newImage(bulletSprite)
  bullet = HC.rectangle(player.x, player.y - player.img:getHeight() - 20, img:getWidth(), img:getHeight());
  bullet.img = img
  bullet.type = "Bullet"
  bullet.speed = 25

  table.insert(bullets, bullet)

  love.audio.newSource(bulletAudioSource, "static"):play()
end

local function updateBullets(dt)
  for k,bullet in pairs(bullets) do
    local x, y = bullet:center()
    y = y - bullet.speed
    bullet:moveTo(x, y)

    if(y < -50) then
      HC.remove(bullet)
      table.remove(bullets, k)
    end

    for shape, delta in pairs(HC.collisions(bullet)) do
      if(shape.type == "Meteor") then
        print(shape.type)
        HC.remove(shape)
        meteors.remove()
      end

  --    text[#text+1] = string.format("Colliding. Separating vector = (%s,%s) - %s -> %s",
  --    delta.x, delta.y, shape.thename, rot)
    end

  end
end

local function drawBullets()
  for k,bullet in pairs(bullets) do
    local x, y = bullet:center()
    love.graphics.draw(bullet.img, x, y, 0, 1, 1, bullet.img:getWidth() / 2, bullet.img:getHeight() / 2)
    if isDebug then
        love.graphics.setColor(255, 0, 0, 140)
        bullet:draw('fill')
        love.graphics.setColor(255, 255, 255, 255)
    end
  end
end

--[[
  *** FUNZIONI GLOBALI ***
]]

-- inizializza i dati della navicella
function player.load()
  player.img = love.graphics.newImage(sprite)
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() - 80

  -- crea il poligono per le collisioni
  player.shapeHC = HC.polygon(0, -60, player.img:getWidth() / 2, 0, -player.img:getWidth() / 2, 0)

end

function player.update(dt)
  -- controllo il movimento della navicella
  if (love.keyboard.isDown("left")) then
    player.velX = player.velX - player.acc
  elseif(love.keyboard.isDown("right")) then
    player.velX = player.velX + player.acc
  elseif(player.velX > 0) then
    player.velX = player.velX - player.dec
  elseif(player.velX < 0) then
    player.velX = player.velX + player.dec
  end

  -- se velX è estremamente piccola, per sicurezza, la setto a zero
  if(
    player.velX < 0.3 and
    player.velX > -0.3
  ) then
    player.velX = 0
  end

  -- controllo il movimento orizzontale (bordi, etc.)
  if (player.x < player.img:getWidth() / 2 - player.velX) then
    player.velX = 0
    player.x = player.img:getWidth() / 2
  elseif (player.x > love.graphics.getWidth() - player.velX - player.img:getWidth() / 2) then
    player.velX = 0
    player.x = love.graphics.getWidth() - player.img:getWidth() / 2
  else
    if(player.velX > player.maxVel) then
      player.velX = player.maxVel
    elseif((player.velX < -player.maxVel)) then
      player.velX = -player.maxVel
    end
    player.x = player.x + player.velX
  end

  player.shapeHC:moveTo(player.x, player.y)

  updateBullets(dt)
end

function player.draw()
  love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, player.img:getWidth() / 2, player.img:getHeight() / 2)

  drawBullets()

  -- se in debug mode, mostra gli elementi di HC
  if isDebug then
      love.graphics.setColor(255, 0, 0, 255)
      player.shapeHC:draw('line')
      love.graphics.setColor(255, 0, 0, 100)
      player.shapeHC:draw('fill')
  end
  love.graphics.setColor(255,255,255, 255)
end

-- crea un proiettile
function player.fireBullet()
  createBullet()
end

return player
