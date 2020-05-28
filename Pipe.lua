Pipe = Class {}
local PIPE_IMAGE = love.graphics.newImage("assets/pipe.png")

PIPE_SCROLL = 60

-- height of pipe image, globally accessible
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(position, y)
  self.x = VIRTUAL_WIDTH
  self.y = y

  -- self.image = PIPE_IMAGE
  self.width = PIPE_IMAGE:getWidth()
  self.height = PIPE_HEIGHT

  self.position = position
end

function Pipe:update(dt)
end

function Pipe:render()
  love.graphics.draw(
    PIPE_IMAGE,
    self.x,
    (self.position == "top" and self.y + PIPE_HEIGHT or self.y),
    0,
    1,
    self.position == "top" and -1 or 1
  )
end
