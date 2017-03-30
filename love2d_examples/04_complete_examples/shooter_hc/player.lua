local HC = require "libs.HC"

local player = {}

--[[
  *** VARIABILI GLOBALI ***
]]

player.x = 0
player.y = 0
player.img = nil
player.width = 0
player.height = 0
player.velX = 0
player.velY = 0
player.acc = 2
player.dec = 0.4
player.maxVel = 8

player.isDebug = true

--[[
  *** VARIABILI LOCALI ***
]]

local singleBulletActive = true
local doubleBulletActive = false
local bigBulletActive = false

local sprite = "assets/player.png"
local bulletSprite = "assets/laser01.png"

local bulletAudioSource = "assets/laser01.wav"

local bigBulletFireRate = 1
local bigBulletTimer = 0;

local bullets = {} -- tabella che conterrà i dati dei proiettili

--[[
  *** FUNZIONI LOCALI ***
]]

local function createBullet()
  if(not singleBulletActive) then return end

  local bullet = {}
  -- posiziona il proiettile proprio davanti alla navicella
  bullet.img = love.graphics.newImage(bulletSprite)
  bullet.x = player.x
  bullet.y = player.y - player.height / 2
  bullet.speed = 5
  bullet.width = bullet.img:getWidth()
  bullet.height = bullet.img:getHeight()
  bullet.shapeHC = HC.rectangle(0, 0, bullet.width, bullet.height);
  table.insert(bullets, bullet)

  love.audio.newSource(bulletAudioSource, "static"):play()
end

local function updateBullets(dt)
  for k,bullet in pairs(bullets) do
    bullet.y = bullet.y - bullet.speed
    bullet.shapeHC:moveTo(bullet.x, bullet.y)

    if(bullet.y < -50) then
      table.remove(bullets, k)
    end
  end

  if(bigBulletTimer > 0) then
    bigBulletTimer = bigBulletTimer - dt
  end

end

local function drawBullets()
  for k,bullet in pairs(bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y, bullet.rotation, 1, 1, bullet.width / 2, bullet.height / 2)
    if isDebug then
        love.graphics.setColor(255, 0, 0, 140)
        bullet.shapeHC:draw('fill')
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
  player.width = player.img:getWidth()
  player.height = player.img:getHeight()
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() - 80

  -- crea il poligono per le collisioni
  player.shapeHC = HC.polygon(0, -60, player.width / 2, 0, -player.width / 2, 0)

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
  if (player.x < player.width / 2 - player.velX) then
    player.velX = 0
    player.x = player.width / 2
  elseif (player.x > love.graphics.getWidth() - player.velX - player.width / 2) then
    player.velX = 0
    player.x = love.graphics.getWidth() - player.width / 2
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
  love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)

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
