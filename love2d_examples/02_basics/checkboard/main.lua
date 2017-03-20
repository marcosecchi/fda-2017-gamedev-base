function love.load(arg)
  tileSize = 32

  map = {}

  for colums=1,10 do
    map[colums] = {}

    for cols=1,10 do
      if(colums % 2 == 0) then
        if(cols % 2 == 0) then
          map[colums][cols] = "white"
        else
          map[colums][cols] = "black"
        end
      else
        if(cols % 2 == 0) then
          map[colums][cols] = "black"
        else
          map[colums][cols] = "white"
        end
      end
    end
  end
end

function love.update(dt)
end

function love.draw()
  for colums=1,table.getn(map) do
    for cols=1,table.getn(map[colums]) do
      if(map[colums][cols] == "white") then
        love.graphics.setColor(255, 255, 255, 255)
      else
        love.graphics.setColor(0, 0, 0, 255)
      end
      love.graphics.rectangle(
          "fill",
          tileSize * colums - tileSize,
          tileSize * cols - tileSize,
          tileSize,
          tileSize)
    end
  end
end
