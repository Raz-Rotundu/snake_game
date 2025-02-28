# Collections of things for the snake game

require 'gosu'
require_relative 'sconst.rb'
require_relative 'better_snake.rb'

module Scollect
  include Sconst
  include Snake

  # Collection of animation frames + api
  class Animation
    def initialize(addr, tile_width, tile_height)
      @frames = Gosu::Image.load_tiles(addr, tile_width, tile_height)
    end

    def next()
      return @frames[(Gosu.milliseconds / Sconst::REFRESH) % @frames.length()]

    end
  end

  # A collection of snake body segments + api
  class Snake_Body
    def initialize(head)
      @segments = []
      @first = @last = nil
      @head = head
    end

    # Adds a new segment to the body, updating pre and post values
    def add()
      s = Snake::Body_segment.new(@head)
      if @segments.length == 0
        s.x = @head.x - 10
        s.y = @head.y - 10
        s.pre = @head
        @segments.append(s) 
      else
        @segments[-1] = p
        s.x = p.x - 10
        s.y = p.y - 10
        s.pre = p
        @segments.append(s)
        p.post = @segments[-1]
      end        
    end

    def clear()
      @segments = []
      @first = @last = nil
    end

    #TODO move function alters position of each member
    def move()
      @segments.each do |seg|
        seg.x = seg.pre.x
        seg.y = seg.pre.y
      end
    end

    def draw()
      @segments.each do |s|
        s.draw()
      end
    end
  end

end

