local background = {}

--[[
  *** VARIABILI GLOBALI ***
]]

background.img = nil

--[[
  *** VARIABILI LOCALI ***
]]

local layer1a = {}
local layer1b = {}
local layer2a = {}
local layer2b = {}

local layer1Speed = .5
local layer2Speed = 3

local sprite = "assets/bg.png"
local sprite2 = "assets/bg2.png"

--[[
  *** FUNZIONI LOCALI ***
]]

--[[
  *** FUNZIONI GLOBALI ***
]]

-- inizializza i dati dello sfondo
function background.load()
  background.img = love.graphics.newImage(sprite)
  background.img2 = love.graphics.newImage(sprite2)

  layer1a.quad = love.graphics.newQuad(0, 0, background.img:getWidth(), background.img:getHeight(), background.img:getDimensions())
  layer1b.quad = love.graphics.newQuad(0, 0, background.img:getWidth(), background.img:getHeight(), background.img:getDimensions())
  layer2a.quad = love.graphics.newQuad(0, 0, background.img2:getWidth(), background.img2:getHeight(), background.img2:getDimensions())
  layer2b.quad = love.graphics.newQuad(0, 0, background.img2:getWidth(), background.img2:getHeight(), background.img2:getDimensions())
  layer1a.pos = 0
  layer1b.pos = layer1a.pos - background.img:getHeight()
  layer2a.pos = 0
  layer2b.pos = layer2a.pos - background.img:getHeight()
end

function background.update(dt)
  layer1a.pos = layer1a.pos + layer1Speed
  layer1b.pos = layer1b.pos + layer1Speed
  layer2a.pos = layer2a.pos + layer2Speed
  layer2b.pos = layer2b.pos + layer2Speed

  if(layer1a.pos >= background.img:getHeight()) then
    layer1a.pos = layer1b.pos - background.img:getHeight()
  end
  if(layer1b.pos >= background.img:getHeight()) then
    layer1b.pos = layer1a.pos - background.img:getHeight()
  end
  if(layer2a.pos >= background.img:getHeight()) then
    layer2a.pos = layer2b.pos - background.img:getHeight()
  end
  if(layer2b.pos >= background.img:getHeight()) then
    layer2b.pos = layer2a.pos - background.img:getHeight()
  end
end

function background.draw()
  love.graphics.draw(background.img, layer1a.quad, 0, layer1a.pos)
  love.graphics.draw(background.img, layer1b.quad, 0, layer1b.pos)
  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.draw(background.img2, layer2a.quad, 0, layer2a.pos)
  love.graphics.draw(background.img2, layer2b.quad, 0, layer2b.pos)
  love.graphics.setColor(255, 255, 255, 255)
end

return background
