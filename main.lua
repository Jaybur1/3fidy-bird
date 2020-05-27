push = require "push"

Class = require "class"

require "Bird"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Load Images

--handle background
local background = love.graphics.newImage("assets/background.png")
local backgroundScroll = 0
local BACKGROUND_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413
--handle ground
local ground = love.graphics.newImage("assets/ground.png")
local groundScroll = 0
local GROUND_SPEED = 60

-- local pipe = love.graphics.newImage("assets/pipe.png")
-- local bird = love.graphics.newImage("assets/bird.png")
-- local fiddy = love.graphics.newImage("assets/3fiddy.png")

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

  --init Bird
   bird = Bird()
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT

  groundScroll = (groundScroll + GROUND_SPEED * dt) % VIRTUAL_WIDTH
end

function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundScroll, 0)

  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  bird:render()
  displayTitle()
  push:finish()
end

function displayTitle()
  love.graphics.setFont(titleFont)
  love.graphics.printf("3-Fiddy bird", 0, 50, VIRTUAL_WIDTH, "center")
  love.graphics.setFont(smallFont)
  love.graphics.printf("Press ENTER to start", 0, 80, VIRTUAL_WIDTH, "center")
end
