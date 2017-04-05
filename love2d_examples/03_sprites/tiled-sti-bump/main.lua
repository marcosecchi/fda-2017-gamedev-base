local bump  = require 'libs.bump'
local sti   = require 'libs.sti'

-- World creation
local world = bump.newWorld()

-- Player functions
local player = { x = 70, y = 70, w = 20, h = 20, speed = 80, status = "normal" }

-- funzione utilizzata da bump per bloccare il movimento solo sul terreno impassabile
local function filterMovement(item, other)
  if other.properties.impassable then
    return "slide" -- non permette di attraversare il terreno
  end
  return "cross" -- permette di attraversare il terreno
end

function love.load()
  -- carica la mappa inizializzandola con bump
  -- gli oggetti, definiti in Tiled come 'collidable' verranno presi in considerazione
  -- durante le collisioni
  map = sti("assets/map.lua", { "bump" })
  map:bump_init(world)
  -- aggiunge il giocatore a bump
  world:add(player, player.x, player.y, player.w, player.h)
end

function love.update(dt)
  -- calcola il delta di movimento del personaggio
  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = player.speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -player.speed * dt
  end
  if love.keyboard.isDown('down') then
    dy = player.speed * dt
  elseif love.keyboard.isDown('up') then
    dy = -player.speed * dt
  end

  -- se il personaggio si dovrebbe muovers, controlla le collisioni
  if dx ~= 0 or dy ~= 0 then
    local cols      -- collisioni
    local cols_len  -- numero di collisioni
    player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy, filterMovement)
    for _,col in ipairs(cols) do
      if col.other.properties.impassable then
        player.status = "Touching impassable terrain"
      elseif col.other.properties.hot then
        player.status = "On hot terrain"
      end
    end
    if(cols_len == 0) then
      player.status = "On walkable terrain"
    end
  end
end

function love.draw()
	map:draw()

  if player.status == "On hot terrain" then
    love.graphics.setColor(255, 0, 0, 150)
  else
    love.graphics.setColor(0, 0, 0, 70)
  end
  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.rectangle("line", player.x, player.y, player.w, player.h)
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.print("Player status: " .. player.status, 5, 5)
end
