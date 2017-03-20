-- inizializzo la tabella player
player = {}

-- inizializzo la tabella lake
lake = {}

function love.load(arg)
  -- setto i valori iniziali di player
  player.posX = 10  -- posizione x
  player.posY = 10  -- posizione y
  player.size = 30  -- dimensioni
  player.move = 1   -- movimento per update
  player.walk = 1   -- valore da assegnare a move quando cammina
  player.run = 3    -- valore da assegnare a move quando corre

  -- setto i valori iniziali di lake
  lake.posX = 150   -- posizione x (rappresenta il centro, dato che sarà circolare)
  lake.posY = 150   -- posizione y (rappresenta il centro, dato che sarà circolare)
  lake.size = 50    -- raggio del lago

end

function love.update(dt)
  -- se la barra spaziatrice è premuta, il player corre, quindi assegnamo il
  -- valore corrispondente. Se invece non è premuta, assegnamo il valore di camminata
  if love.keyboard.isDown("space") then
    player.move = player.run
  else
    player.move = player.walk
  end

  -- controllo il movimento orizzontale tramite i tasti 'a' (sinistra) e 'd' (destra)
  -- aggiorno la posizione X del giocatore di conseguenza
  if love.keyboard.isDown("d") then
      player.posX = player.posX + player.move
  elseif love.keyboard.isDown("a") then
    player.posX = player.posX - player.move
  end

  -- controllo il movimento verticale tramite i tasti 'w' (in alto) e 's' (in basso)
  -- aggiorno la posizione X del giocatore di conseguenza
  if love.keyboard.isDown("w") then
      player.posY = player.posY - player.move
  elseif love.keyboard.isDown("s") then
    player.posY = player.posY + player.move
  end

  -- controllo che il giocatore non esca dallo schermo orizzontalmente
  if player.posX < 0 then
    player.posX = 0
  elseif player.posX > love.graphics.getWidth() - player.size then
    player.posX = love.graphics.getWidth() - player.size
  end

  -- controllo che il giocatore non esca dallo schermo verticalmentee
  if player.posY < 0 then
    player.posY = 0
  elseif player.posY > love.graphics.getHeight() - player.size then
    player.posY = love.graphics.getHeight() - player.size
  end

end

function love.draw()

  -- cambio il colore di disegno in azzurro e disegno il lago (un cerchio)
  love.graphics.setColor(80, 100, 200, 255)
  love.graphics.circle("fill", lake.posX, lake.posY, lake.size, 20)

  -- cambio il colore di disegno in bianco e disegno il personaggio (un rettangolo)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle("fill", player.posX, player.posY, player.size, player.size)

end
