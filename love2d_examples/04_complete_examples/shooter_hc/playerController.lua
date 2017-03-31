local HC = require "libs.HC"
local meteorsController = require ("meteorsController")

--[[
  *** VARIABILI LOCALI ***
]]

local playerController = {}

local sprite = "assets/player.png"
local bulletSprite = "assets/laser01.png"
local bulletAudioSource = "assets/laser01.wav"

local bulletList = {} -- tabella che conterrà i dati dei proiettili

playerController.x = 0
playerController.y = 0
playerController.img = nil
playerController.velX = 0
playerController.velY = 0
playerController.acc = 2
playerController.dec = 0.4
playerController.maxVel = 8
playerController.isDebug = true

--[[
  *** FUNZIONI LOCALI ***
]]

local function createBullet()
  local img = love.graphics.newImage(bulletSprite)
  bullet = HC.rectangle(playerController.x, playerController.y - playerController.img:getHeight() - 20, img:getWidth(), img:getHeight());
  bullet.img = img
  bullet.type = "Bullet"
  bullet.speed = 25

  table.insert(bulletList, bullet)

  love.audio.newSource(bulletAudioSource, "static"):play()
end

local function updateBullets(dt)
  -- muove i proiettili
  for k,bullet in pairs(bulletList) do
    local x, y = bullet:center()
    y = y - bullet.speed
    bullet:moveTo(x, y)

    if(y < -50) then
      HC.remove(bullet)
      table.remove(bulletList, k)
    end

    for shape, delta in pairs(HC.collisions(bullet)) do
      if(shape.type == "Meteor") then
        print("Collision with: " .. shape.type .. "(" .. shape.points .. " points)")

        -- distrugge il meteorite
        HC.remove(shape)
        meteorsController.remove(shape)

        -- distrugge il proiettile
        HC.remove(bullet)
        for i,value in ipairs(bulletList) do
          if bullet == value then
            table.remove(bulletList, i)
            break
          end
        end
      end
    end
  end
end

local function drawBullets()
  for k,bullet in pairs(bulletList) do
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
function playerController.load()
  playerController.img = love.graphics.newImage(sprite)
  playerController.x = love.graphics.getWidth() / 2
  playerController.y = love.graphics.getHeight() - 80

  -- crea il poligono per le collisioni
  playerController.shapeHC = HC.polygon(0, -60, playerController.img:getWidth() / 2, 0, -playerController.img:getWidth() / 2, 0)

end

function playerController.update(dt)
  -- controllo il movimento della navicella
  if (love.keyboard.isDown("left")) then
    playerController.velX = playerController.velX - playerController.acc
  elseif(love.keyboard.isDown("right")) then
    playerController.velX = playerController.velX + playerController.acc
  elseif(playerController.velX > 0) then
    playerController.velX = playerController.velX - playerController.dec
  elseif(playerController.velX < 0) then
    playerController.velX = playerController.velX + playerController.dec
  end

  -- se velX è estremamente piccola, per sicurezza, la setto a zero
  if(
    playerController.velX < 0.3 and
    playerController.velX > -0.3
  ) then
    playerController.velX = 0
  end

  -- controllo il movimento orizzontale (bordi, etc.)
  if (playerController.x < playerController.img:getWidth() / 2 - playerController.velX) then
    playerController.velX = 0
    playerController.x = playerController.img:getWidth() / 2
  elseif (playerController.x > love.graphics.getWidth() - playerController.velX - playerController.img:getWidth() / 2) then
    playerController.velX = 0
    playerController.x = love.graphics.getWidth() - playerController.img:getWidth() / 2
  else
    if(playerController.velX > playerController.maxVel) then
      playerController.velX = playerController.maxVel
    elseif((playerController.velX < -playerController.maxVel)) then
      playerController.velX = -playerController.maxVel
    end
    playerController.x = playerController.x + playerController.velX
  end

  playerController.shapeHC:moveTo(playerController.x, playerController.y)

  updateBullets(dt)
end

function playerController.draw()
  love.graphics.draw(playerController.img, playerController.x, playerController.y, 0, 1, 1, playerController.img:getWidth() / 2, playerController.img:getHeight() / 2)

  drawBullets()

  -- se in debug mode, mostra gli elementi di HC
  if isDebug then
      love.graphics.setColor(255, 0, 0, 255)
      playerController.shapeHC:draw('line')
      love.graphics.setColor(255, 0, 0, 100)
      playerController.shapeHC:draw('fill')
  end
  love.graphics.setColor(255,255,255, 255)
end

-- crea un proiettile
function playerController.fireBullet()
  createBullet()
end

return playerController
