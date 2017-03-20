function love.load(arg)
  cowboy = dofile("cowboy.lua")
  cowgirl = dofile("cowgirl.lua")

  frame = 1;
  selectedCharacter = cowboy
  frameDuration = 0.10
  timeElapsed = 0
end

function love.update(dt)
  timeElapsed = timeElapsed + dt

  if(timeElapsed >= frameDuration) then
    frame = frame + 1
    if frame > table.getn(selectedCharacter.animations) then
      frame = 1
    end
    timeElapsed = 0
  end
end

function love.draw()
  image = love.graphics.newImage(selectedCharacter.animations[frame])
  love.graphics.draw(image, 100, 100)
end
