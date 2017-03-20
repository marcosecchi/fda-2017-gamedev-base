function love.load(arg)
  -- crea due variabili che contengono le immagini da utilizzare più avanti
  character = love.graphics.newImage("assets/images/character.png")
  bg = love.graphics.newImage("assets/images/bg.png")
end

function love.draw()
  -- stampa le due immagini a schermo, indicando le coordinate di posizionamento
  love.graphics.draw(bg, 0, -300)
  love.graphics.draw(character, 100, 100)
end
