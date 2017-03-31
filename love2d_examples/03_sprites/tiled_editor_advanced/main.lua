local sti = require "sti"
local map

local keyTaken = false


function love.load(arg)
  -- instanzio la mappa generata con Tiled utilizzando sti
  map = sti("assets/map1.lua") -- commentare questa linea e decommentare la successiva per vedere un'altra mappa
--  map = sti("assets/map2.lua")

  -- creo gli sprite del personaggio e dell'uscita tramite dua quad
  tileset = love.graphics.newImage("assets/fantasy-tileset.png")
  local tileWidth = map.tilewidth
  local tileHeight = map.tileheight

  -- inizializza i dati del personaggio
  player = {}

  -- inizializza i dati dello scrigno
  chest = {}

  -- inizializza i dati della chiave
  key = {}

  -- cerca gli spawn points per il personaggio e per l'uscita
  for k, object in pairs(map.objects) do
    if object.name == "Player" then
      player.startX = object.x
      player.startY = object.y
      player.x = object.x
      player.y = object.y
      player.quad = love.graphics.newQuad(object.properties["tileX"] * tileWidth, object.properties["tileY"] * tileHeight, tileWidth, tileHeight, tileset:getDimensions())
    elseif object.name == "Chest" then
      chest.x = object.x
      chest.y = object.y
      chest.quad = love.graphics.newQuad(object.properties["closedX"] * tileWidth, object.properties["closedY"] * tileHeight, tileWidth, tileHeight, tileset:getDimensions())
      chest.quadOpen = love.graphics.newQuad(object.properties["openX"] * tileWidth, object.properties["openY"] * tileHeight, tileWidth, tileHeight, tileset:getDimensions())
    elseif object.name == "Key" then
      key.x = object.x
      key.y = object.y
      key.quad = love.graphics.newQuad(object.properties["tileX"] * tileWidth, object.properties["tileY"] * tileHeight, tileWidth, tileHeight, tileset:getDimensions())
    end
  end

  -- rimuove il livello degli spawn points perché sono già stati trovati e salvati
  map:removeLayer("SpawnObjects")
end

function love.keypressed(keyValue, scancode, isrepeat)
  -- setta il movimento voluto alla posizione attuale del personaggo
  nextX = player.x
  nextY = player.y

  -- modifica il movimento voluto senza modificare i dati del personaggio
  if(keyValue == "up") then
    nextY = nextY - map.tileheight
  elseif (keyValue == "down") then
    nextY = nextY + map.tileheight
  elseif (keyValue == "left") then
    nextX = nextX - map.tilewidth
  elseif (keyValue == "right") then
    nextX = nextX + map.tilewidth
  end

  -- controlla le zone impassabili, utilizzando la proprietà personalizzata 'isImpassable'
  local impassableZone
  -- se alla fine di tutti i controlli 'canMove' sarà ancora 'true',
  -- vorrà dire che è possibile muoversi nel punto desiderato
  local canMove = true
  for k, object in pairs(map.objects) do
    if object.properties["isImpassable"] == true then
      if ( nextX >= object.x and
           nextX < object.x + object.width and
           nextY >= object.y and
           nextY < object.y + object.height ) then
        canMove = false
        break
      end
    end
  end

  -- se è possibile muoversi, aggiorna la posizione del personaggio
  if(canMove) then
    player.x = nextX
    player.y = nextY
    if(player.x == key.x and player.y == key.y) then
      keyTaken = true
    end
  end

  -- se ha trovato l'uscita riposiziona al punto di partenza
  if player.x == chest.x and player.y == chest.y then
    player.x = player.startX
    player.y = player.startY
  end
end

function love.update(dt)
  map:update(dt)
end

function love.draw()
  map:draw() -- disegna la mappa
  if(not keyTaken) then
    love.graphics.draw(tileset, chest.quad, chest.x, chest.y)
    love.graphics.draw(tileset, key.quad, key.x, key.y)
  else
    love.graphics.draw(tileset, chest.quadOpen, chest.x, chest.y)
  end
  love.graphics.draw(tileset, player.quad, player.x, player.y)
end
