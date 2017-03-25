local sti = require "sti"
local map

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
  player.quad = love.graphics.newQuad(0, 576, tileWidth, tileHeight, tileset:getDimensions())

  -- inizializza i dati dell'uscita
  exit = {}
  exit.quad = love.graphics.newQuad(160, 32, tileWidth, tileHeight, tileset:getDimensions())

  -- cerca gli spawn points per il personaggio e per l'uscita
  for k, object in pairs(map.objects) do
    if object.name == "Player" then
      player.startX = object.x
      player.startY = object.y
      player.x = object.x
      player.y = object.y
    elseif object.name == "Exit" then
      exit.x = object.x
      exit.y = object.y
    end
  end

  -- rimuove il livello degli spawn points perché sono già stati trovati e salvati
  map:removeLayer("SpawnObjects")
end

function love.keypressed(key, scancode, isrepeat)
  -- setta il movimento voluto alla posizione attuale del personaggo
  nextX = player.x
  nextY = player.y

  -- modifica il movimento voluto senza modificare i dati del personaggio
  if(key == "up") then
    nextY = nextY - map.tileheight
  elseif (key == "down") then
    nextY = nextY + map.tileheight
  elseif (key == "left") then
    nextX = nextX - map.tilewidth
  elseif (key == "right") then
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
  end

  -- se ha trovato l'uscita riposiziona al punto di partenza
  if player.x == exit.x and player.y == exit.y then
    player.x = player.startX
    player.y = player.startY
  end
end

function love.update(dt)
  map:update(dt)
end

function love.draw()
  map:draw() -- disegna la mappa
  love.graphics.draw(tileset, exit.quad, exit.x, exit.y) -- disegna l'uscita
  love.graphics.draw(tileset, player.quad, player.x, player.y) -- disegna il personaggio
end
