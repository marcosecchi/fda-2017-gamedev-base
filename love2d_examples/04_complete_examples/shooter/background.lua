local background = {}

--[[
  *** VARIABILI GLOBALI ***
]]

background.img = nil

--[[
  *** VARIABILI LOCALI ***
]]

local sprite = "assets/bg.png"

--[[
  *** FUNZIONI LOCALI ***
]]

--[[
  *** FUNZIONI GLOBALI ***
]]

-- inizializza i dati dello sfondo
function background.init()
  background.img = love.graphics.newImage(sprite)
end


return background
