local HC = require "libs.HC"

--[[
  *** VARIABILI LOCALI ***
]]
local meteorsController = {}

local sprites = {"assets/meteor1.png", "assets/meteor2.png", "assets/meteor3.png"}
local meteorList = {}

--[[
  *** VARIABILI GLOBALI ***
]]
meteorsController.isDebug = true

--[[
  *** FUNZIONI GLOBALI ***
]]

function meteorsController.load()

  for i=1,3 do
    local posX, posY = 130 * i, 100
    local img = love.graphics.newImage(sprites[i])
    local meteor = HC.circle(posX, posY, img:getWidth() / 2);
    meteor.type = "Meteor"
    meteor.img = img
    meteor.rotation = 0
    meteor.rotationSpeed = i

    table.insert(meteorList, meteor)
  end
end

function meteorsController.update(dt)
  for i,meteor in ipairs(meteorList) do
    meteor.rotation = meteor.rotation + meteor.rotationSpeed * dt
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
  end
end

function meteorsController.remove(meteor)
  for i,value in ipairs(meteorList) do
    if meteor == value then
      table.remove(meteorList, i)
    end
  end
end

return meteorsController
