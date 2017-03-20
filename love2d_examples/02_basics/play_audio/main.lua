function love.load(arg)
  beep = love.audio.newSource("assets/audio/beep.wav", "static")
end

function love.keypressed(key, scancode, isrepeat)
  if (key == "space") then
    beep:play()
  end
end
