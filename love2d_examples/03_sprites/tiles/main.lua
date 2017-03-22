function love.load(arg)
  stopSound = love.audio.newSource("assets/audio/stop.wav", "static") -- carica l'audio da riprodurre quando non si può camminare
  mapData = dofile("map_data.lua") -- carica i dati della mappa

  mapImages = {} -- crea una mappa per le immagini
  for i=1,table.getn(mapData.codes) do -- cicla sui codici della mappa e genera le immagini corrispondenti
    local key = mapData.codes[i].key
    local path = mapData.codes[i].path
    mapImages[key] = love.graphics.newImage(path)
  end

  player = {} -- crea i dati del personaggio
  player.image = love.graphics.newImage("assets/images/149.png") -- carica l'immagine del personaggio
  player.posX = 2 -- inizializza la posizione x
  player.posY = 2 -- inizializza la posizione y
end

function love.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
   -- inizializza i dati per la prossima posizione
   -- per controllare se è raggiungibile
  local nextPosX = player.posX
  local nextPosY = player.posY

  -- calcola il movimento verticale voluto
  if(key == "up") then
    nextPosY = nextPosY - 1
  elseif (key == "down") then
    nextPosY = nextPosY + 1
  end

  -- calcola il movimento orizzontale voluto
  if(key == "right") then
    nextPosX = nextPosX + 1
  elseif (key == "left") then
    nextPosX = nextPosX - 1
  end

  -- se la posizione calcolata è raggiungibile, cioè se la mappa, nel punto calcolato,
  -- è di tipo 'walkable', aggiorna la posizione del personaggio, altrimenti
  -- emetti un suono di feedback
  if(mapData.map[nextPosY][nextPosX] == mapData.walkableCode) then
    player.posX = nextPosX
    player.posY = nextPosY
  else
    stopSound:play()
  end
end

function love.draw()
  -- disegna la mappa
  for rows=1,table.getn(mapData.map) do  -- cicla sulle colonne
    for columns=1,table.getn(mapData.map[rows]) do  -- cicla sulle righe
      love.graphics.draw(
          mapImages[mapData.map[columns][rows]],
          mapData.tileSize * rows - mapData.tileSize,
          mapData.tileSize * columns - mapData.tileSize
      )
    end
  end

  -- disegna il personaggio
  love.graphics.draw(
    player.image,
    mapData.tileSize * player.posX - mapData.tileSize,
    mapData.tileSize * player.posY - mapData.tileSize
  )
end
