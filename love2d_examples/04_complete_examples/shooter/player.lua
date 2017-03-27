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

--[[
  *** VARIABILI LOCALI ***
]]

local singleBulletActive = true
local doubleBulletActive = false
local bigBulletActive = false

local sprite = "assets/player.png"
local bulletSprite = "assets/laser01.png"
local doubleBulletSprite = "assets/laser02.png"
local bigBulletSprite = "assets/laser03.png"

local bulletAudioSource = "assets/laser01.wav"
local doubleBulletAudioSource = "assets/laser02.wav"
local bigBulletAudioSource = "assets/laser03.wav"

local bigBulletFireRate = 1
local bigBulletTimer = 0;

local bullets = {} -- tabella che conterrà i dati dei proiettili

--[[
  *** FUNZIONI LOCALI ***
]]

local function createSingleBullet()
  if(not singleBulletActive) then return end

  local bullet = {}
  -- posiziona il proiettile proprio davanti alla navicella
  bullet.img = love.graphics.newImage(bulletSprite)
  bullet.x = player.x
  bullet.y = player.y - player.height / 2
  bullet.speed = 30
  bullet.width = bullet.img:getWidth()
  bullet.height = bullet.img:getHeight()
  table.insert(bullets, bullet)

  love.audio.newSource(bulletAudioSource, "static"):play()
end

local function createDoubleBullet()
  if(not doubleBulletActive) then return end

  -- crea il proiettile sinistro
  local lBullet = {}
  lBullet.img = love.graphics.newImage(doubleBulletSprite)
  lBullet.x = player.x - player.width / 2
  lBullet.y = player.y - player.height / 2
  lBullet.speed = 20
  lBullet.width = lBullet.img:getWidth()
  lBullet.height = lBullet.img:getHeight()
  table.insert(bullets, lBullet)

  -- crea il proiettile destro
  local rBullet = {}
  rBullet.img = love.graphics.newImage(doubleBulletSprite)
  rBullet.x = player.x + player.width / 2
  rBullet.y = player.y - player.height / 2
  rBullet.speed = 20
  rBullet.width = rBullet.img:getWidth()
  rBullet.height = rBullet.img:getHeight()
  table.insert(bullets, rBullet)

  love.audio.newSource(doubleBulletAudioSource, "static"):play()
end

local function createBigBullet()
  if(not bigBulletActive) then return end
  if(bigBulletTimer > 0) then return end

  local bullet = {}
  -- posiziona il proiettile proprio davanti alla navicella
  bullet.img = love.graphics.newImage(bigBulletSprite)
  bullet.x = player.x
  bullet.y = player.y - player.height / 2
  bullet.speed = 5
  bullet.width = bullet.img:getWidth()
  bullet.height = bullet.img:getHeight()
  bullet.rotation = 0
  table.insert(bullets, bullet)

  bigBulletTimer = bigBulletFireRate

  love.audio.newSource(bigBulletAudioSource, "static"):play()
end

local function updateBullets(dt)
  for k,bullet in pairs(bullets) do
    bullet.y = bullet.y - bullet.speed
    if bullet.rotation then
      bullet.rotation = bullet.rotation + dt
    end

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
    player.x = player.width / 2 - player.velX
  elseif (player.x > love.graphics.getWidth() - player.velX - player.width / 2) then
    player.velX = 0
    player.x = love.graphics.getWidth() - player.velX - player.width / 2
  else
    if(player.velX > player.maxVel) then
      player.velX = player.maxVel
    elseif((player.velX < -player.maxVel)) then
      player.velX = -player.maxVel
    end
    player.x = player.x + player.velX
  end

  updateBullets(dt)
end

function player.draw()
  love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)

  drawBullets()
end

-- crea un proiettile
function player.fireBullet()
  createSingleBullet()
  createDoubleBullet()
  createBigBullet()
end

function player.toggleSingleBullet()
  singleBulletActive = not singleBulletActive
end

function player.toggleDoubleBullet()
  doubleBulletActive = not doubleBulletActive
end

function player.toggleBigBullet()
  bigBulletActive = not bigBulletActive
end

return player
