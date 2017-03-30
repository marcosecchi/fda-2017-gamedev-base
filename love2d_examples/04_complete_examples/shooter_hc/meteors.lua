local HC = require "libs.HC"

--[[
  *** VARIABILI LOCALI ***
]]
local meteors = {}

local sprite = "assets/meteor1.png"

meteors.isDebug = true

--[[
  *** FUNZIONI LOCALI ***
]]

--[[
  *** FUNZIONI GLOBALI ***
]]

function meteors.load()
  meteor = {

  }
  meteor.img = love.graphics.newImage(sprite)
  meteor.x = 100
  meteor.y = 100
  meteor.width = meteor.img:getWidth()
  meteor.height = meteor.img:getHeight()
  meteor.shapeHC = HC.circle(meteor.x, meteor.y, meteor.width / 2);
  meteor.shapeHC.type = "Meteor"

  table.insert(meteors, meteor)
end

function meteors.update(dt)

end

function meteors.draw()
  love.graphics.draw(meteor.img, meteor.x, meteor.y, 0, 1, 1, meteor.width / 2, meteor.height / 2)

  -- se in debug mode, mostra gli elementi di HC
  if isDebug then
      love.graphics.setColor(255, 0, 0, 255)
      meteor.shapeHC:draw('line')
      love.graphics.setColor(255, 0, 0, 100)
      meteor.shapeHC:draw('fill')
  end
  love.graphics.setColor(255,255,255, 255)
end

return meteors
