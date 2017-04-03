local HC = require "libs.HC"

--[[
  *** VARIABILI LOCALI ***
]]
local meteorsController = {}

local sprites = {
    "assets/meteor1.png",
    "assets/meteor2.png",
    "assets/meteor3.png",
    "assets/meteor4.png",
    "assets/meteor5.png",
    "assets/meteor6.png",
    "assets/meteor7.png"
  }
local meteorList = {}

--[[
  *** VARIABILI GLOBALI ***
]]
meteorsController.isDebug = true

--[[
  *** FUNZIONI LOCALI ***
]]

--[[
  *** FUNZIONI GLOBALI ***
]]


function meteorsController.generateMeteors()
  -- genera tre meteoriti e li aggiunge alla lista
  for i=1,3 do
    local posX, posY = 130 * i, -100
    local spriteIndex = love.math.random(table.getn(sprites))
    local img = love.graphics.newImage(sprites[spriteIndex])
    local meteor = HC.circle(posX, posY, img:getWidth() / 2);
    meteor.type = "Meteor"
    meteor.img = img
    meteor.points = 10 * i
    meteor.rotation = 0
    meteor.rotationSpeed = i
    meteor.speed = love.math.random(100, 200)

    table.insert(meteorList, meteor)
  end
end

function meteorsController.load()
end

function meteorsController.update(dt)
  for i,meteor in ipairs(meteorList) do
    meteor.rotation = meteor.rotation + meteor.rotationSpeed * dt

    local x, y = meteor:center()
    y = y + dt * meteor.speed
    meteor:moveTo(x, y)

    if(y > love.graphics.getHeight() + 50) then
      meteorsController.remove(meteor)
    end
  end
end

function meteorsController.draw()
  for i,meteor in ipairs(meteorList) do
    local x, y = meteor:center()
    love.graphics.draw(meteor.img, x, y, meteor.rotation, 1, 1, meteor.img:getWidth() / 2, meteor.img:getHeight() / 2)

    -- se in debug mode, mostra gli elementi di HC
    if isDebug then
        love.graphics.setColor(255, 0, 0, 255)
        meteor:draw('line')
        love.graphics.setColor(255, 0, 0, 100)
        meteor:draw('fill')
    end
    love.graphics.setColor(255,255,255, 255)

    if y > love.graphics.getHeight() + 50 then
        meteorsController.remove(meteor)
    end
  end
end

function meteorsController.remove(meteor)
  -- rimuove un meteorite dalla lista
  for i,value in ipairs(meteorList) do
    if meteor == value then
      table.remove(meteorList, i)
      break
    end
  end
end

function meteorsController.getNumMeteors()
  return table.getn(meteorList)
end

return meteorsController
