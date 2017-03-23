function love.load(arg)
  -- inizializza gli assets
  wallSound = love.audio.newSource("assets/audio/wall.wav", "static") -- carica l'audio da riprodurre quando non si può camminare
  stepSound = love.audio.newSource("assets/audio/step.wav", "static") -- carica l'audio da riprodurre quando si cammina
  winSound = love.audio.newSource("assets/audio/win.wav", "static") -- carica l'audio da riprodurre quando si raggiunge l'uscita
  uni05Font = love.graphics.newFont("assets/fonts/uni_05_x/uni05_53.ttf", 30) -- carica l'audio da riprodurre quando non si può camminare
  mapData = dofile("map_data.lua") -- carica i dati della mappa

  -- mappa le immagini
  mapImages = {} -- crea una mappa per le immagini
  for i=1,table.getn(mapData.codes) do -- cicla sui codici della mappa e genera le immagini corrispondenti
    local key = mapData.codes[i].key
    local path = mapData.codes[i].path
    mapImages[key] = love.graphics.newImage(path)
  end

  -- inizializza i modelli dati
  player = {} -- crea i dati del personaggio
  player.image = love.graphics.newImage("assets/images/149.png") -- carica l'immagine del personaggio
  player.posX = math.random(2, 3) -- inizializza la posizione x in un punto casuale delle prime due colonne 'camminabili'
  player.posY = math.random(2, 9) -- inizializza la posizione y in un punto casuale delle righe 'camminabili'

  exit = {}
  exit.image = love.graphics.newImage("assets/images/14.png") -- carica l'immagine dell'uscita
  exit.posX = math.random(8, 9) -- inizializza la posizione x in un punto casuale delle ultime due colonne 'camminabili'
  exit.posY = math.random(2, 9) -- inizializza la posizione y in un punto casuale delle righe 'camminabili'

  game = {} -- crea i dati del gioco
  game.status = "start" -- setta lo stato a 'start'
end

function love.update(dt)
  --
end

function love.keypressed(key, scancode, isrepeat)

  -- controlliamo in che stato di gioco siamo
  if(game.status ~= "play") then
    if(game.status == "start" and key == "space") then
      game.status = "play"
    elseif (game.status == "game over" and key == "space") then
      -- riposiziona personaggio ed uscita
      exit.posX = math.random(8, 9)
      exit.posY = math.random(2, 9)
      player.posX = math.random(2, 3)
      player.posY = math.random(2, 9)
      game.status = "start"
    else
      return -- 'ritorniamo' senza eseguire il codice successivo, perché non siamo in 'play'
    end
  end

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
    stepSound:play()
  else
    wallSound:play()
  end

  -- controlla che il personaggio si trovi nella stessa posizione dell'uscita,
  -- nel qual caso setta lo stato a 'game over'
  if(player.posX == exit.posX and player.posY == exit.posY) then
    winSound:play()
    game.status = "game over"
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

  -- disegna l'uscita
  love.graphics.draw(
    exit.image,
    mapData.tileSize * exit.posX - mapData.tileSize,
    mapData.tileSize * exit.posY - mapData.tileSize
  )

  -- disegna il personaggio
  love.graphics.draw(
    player.image,
    mapData.tileSize * player.posX - mapData.tileSize,
    mapData.tileSize * player.posY - mapData.tileSize
  )

  if(game.status == "start") then
    -- disegno un rettangolo semitrasparente di sfondo
    love.graphics.setColor(0, 0, 0, 200)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(162, 203, 57, 255)
    love.graphics.setFont(uni05Font)
    love.graphics.printf("PRESS 'SPACEBAR' TO START", 20, 100, love.graphics.getWidth() - 20, "center")
  elseif(game.status == "game over") then
    -- disegno un rettangolo semitrasparente di sfondo
    love.graphics.setColor(0, 0, 0, 200)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(162, 203, 57, 255)
    love.graphics.setFont(uni05Font)
    love.graphics.printf("YOU WIN!\n\nPRESS 'SPACEBAR' TO REPLAY", 20, 60, love.graphics.getWidth() - 20, "center")
  end
  -- resetto il colore
  love.graphics.setColor(255, 255, 255, 255)

end
