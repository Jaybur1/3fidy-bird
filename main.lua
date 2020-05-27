push = require "push"

class = require "class"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Load Images
local background = love.graphics.newImage("assets/background.png")
local ground = love.graphics.newImage("assets/ground.png")
local pipe = love.graphics.newImage("assets/pipe.png")
local bird = love.graphics.newImage("assets/bird.png")
local fiddy = love.graphics.newImage("assets/3fiddy.png")

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  love.window.setTitle("3Fiddy Bird")

  smallFont = love.graphics.newFont("assets/font.ttf", 16)
  titleFont = love.graphics.newFont("assets/flappy.ttf", 24)

  --screen setup
  push:setupScreen(
    VIRTUAL_WIDTH,
    VIRTUAL_HEIGHT,
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    {
      vsync = true,
      fullscreen = false,
      resizable = true
    }
  )
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  push:start()
  love.graphics.draw(background, 0, 0)

  love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)

  displayTitle()
  push:finish()
end

function displayTitle()
  love.graphics.setFont(titleFont);
  love.graphics.printf("3-Fiddy bird", 0, 50, VIRTUAL_WIDTH, "center")
  love.graphics.setFont(smallFont);
  love.graphics.printf("Press ENTER to start", 0, 80, VIRTUAL_WIDTH, "center")

end