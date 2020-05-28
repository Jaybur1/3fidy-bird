PipePair = Class {}

local GAP_HEIGHT = math.random(50, 120)

function PipePair:init(y)
  self.scored = false
  self.x = VIRTUAL_WIDTH + 32
  self.y = y

  self.pipes = {
    ["upper"] = Pipe("top", self.y),
    ["lower"] = Pipe("bottom", self.y + PIPE_HEIGHT + math.floor(GAP_HEIGHT))
  }

  self.remove = false
end

function PipePair:update(dt)
  -- remove the pipe from the scene if it's beyond the left edge of the screen,
  -- else move it from right to left
  if self.x > -PIPE_WIDTH then
    self.x = self.x - PIPE_SCROLL * dt
    self.pipes["lower"].x = self.x
    self.pipes["upper"].x = self.x
  else
    self.remove = true
  end

  GAP_HEIGHT = math.random(50, 120)
end

function PipePair:render()
  for k, pipe in pairs(self.pipes) do
    pipe:render()
  end
end
