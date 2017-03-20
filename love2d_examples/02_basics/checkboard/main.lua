function love.load(arg)
  tileSize = 32 -- definisce le dimensioni di una singola tile

  map = {} -- crea la mappa (un array bidimensionale) che conterrà i dati

  for colums=1,10 do -- cicla sulle colonne
    map[colums] = {}
    for rows=1,10 do -- cicla sulle righe
      if(colums % 2 == 0) then  -- a seconda della righa e della colonna assegna il codice del colore
        if(rows % 2 == 0) then
          map[colums][rows] = "white"
        else
          map[colums][rows] = "black"
        end
      else
        if(rows % 2 == 0) then
          map[colums][rows] = "black"
        else
          map[colums][rows] = "white"
        end
      end
    end
  end
end

function love.update(dt)
end

function love.draw()
  for colums=1,table.getn(map) do  -- cicla sulle colonne
    for rows=1,table.getn(map[colums]) do  -- cicla sulle righe
      if(map[colums][rows] == "white") then  -- controlla il colore assegnato all'elemento della tabella
        love.graphics.setColor(255, 255, 255, 255)
      else
        love.graphics.setColor(0, 0, 0, 255)
      end
      love.graphics.rectangle(  -- disegna il rettangolo posizionandolo rispetto
                                -- alla riga e colonna corrispondente
          "fill",
          tileSize * colums - tileSize, tileSize * rows - tileSize,
          tileSize, tileSize)
    end
  end
end
