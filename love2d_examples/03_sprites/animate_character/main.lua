function love.load(arg)
  cowboy = dofile("cowboy.lua")
  cowgirl = dofile("cowgirl.lua")

  frame = 1;  -- definisce il frame selezionato
  selectedCharacter = cowboy  -- definisce il personaggio selezionato
  frameDuration = 0.10  -- definisce la durata di un frame
  timeElapsed = 0 -- calcola il tempo per il cambiamento dei frame
end

function love.update(dt)
  timeElapsed = timeElapsed + dt -- aggiorna il tempo passato dall'ultimo cambio di frame

  if(timeElapsed >= frameDuration) then -- se è ora di cambiare frame...
    frame = frame + 1 -- ... aggiorna l'indice
    if frame > table.getn(selectedCharacter.animations) then -- se l'indice va oltre il numero di element dell'animazione...
      frame = 1 -- ... ritorna al primo frame
    end
    timeElapsed = 0 -- azzera il contatore del tempo
  end
end

function love.draw()
  image = love.graphics.newImage(selectedCharacter.animations[frame]) -- carica l'immagine corretta dalla mappa
  love.graphics.draw(image, 100, 100) -- disegna l'immagine a schermo
end
