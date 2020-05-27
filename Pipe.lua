Pipe = Class{}
local PIPE_IMAGE = love.graphics.newImage("assets/pipe.png")
local PIPE_SCROLL = -60

function Pipe:init()
  self.x = VIRTUAL_WIDTH
  self.y = math.random(VIRTUAL_HEIGHT/ 4, VIRTUAL_HEIGHT - 10)

  self.image = PIPE_IMAGE
end

function Pipe:update(dt)

end