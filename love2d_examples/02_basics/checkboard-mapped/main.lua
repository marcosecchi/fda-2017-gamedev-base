function love.load(arg)
  tileSize = 32 -- definisce le dimensioni di una singola tile

  map = dofile("map.lua") -- carica ed esegue il file estero con la mappa
end

function love.update(dt)
end

function love.draw()
  for rows=1,table.getn(map) do  -- cicla sulle colonne
    for columns=1,table.getn(map[rows]) do  -- cicla sulle righe
      if(map[columns][rows] == "white") then  -- controlla il colore assegnato all'elemento della tabella
                                              -- notare gli indici inversi
        love.graphics.setColor(255, 255, 255, 255)
      elseif (map[columns][rows] == "black") then
        love.graphics.setColor(0, 0, 0, 255)
      else
        love.graphics.setColor(255, 0, 0, 255) -- se non viene trovato un codice, visualizza il colore rosso
      end
      love.graphics.rectangle(  -- disegna il rettangolo posizionandolo rispetto
                                -- alla riga e colonna corrispondente
          "fill",
          tileSize * rows - tileSize, tileSize * columns - tileSize,
          tileSize, tileSize)
    end
  end
end
