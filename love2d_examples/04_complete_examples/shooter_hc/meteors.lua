local HC = require "libs.HC"

--[[
  *** VARIABILI LOCALI ***
]]
local meteors = {}

local sprite = "assets/meteor1.png"

meteors.isDebug = true

--[[
  *** FUNZIONI GLOBALI ***
]]

function meteors.load()

  local posX, posY = 100, 100
  local img = love.graphics.newImage(sprite)
  meteor = HC.circle(posX, posY, img:getWidth() / 2);
  meteor.type = "Meteor"
  meteor.img = img

  table.insert(meteors, meteor)
end

function meteors.update(dt)

end

function meteors.draw()
  if not meteor then return end
  local x, y = meteor:center()
  love.graphics.draw(meteor.img, x, y, 0, 1, 1, meteor.img:getWidth() / 2, meteor.img:getHeight() / 2)

  -- se in debug mode, mostra gli elementi di HC
  if isDebug then
      love.graphics.setColor(255, 0, 0, 255)
      meteor:draw('line')
      love.graphics.setColor(255, 0, 0, 100)
      meteor:draw('fill')
  end
  love.graphics.setColor(255,255,255, 255)
end

function meteors.remove()
  meteor = nil
end

return meteors
