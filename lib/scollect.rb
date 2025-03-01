# Collections of things for the snake game

require 'gosu'
require_relative 'sconst.rb'
require_relative 'better_snake.rb'

module Scollect
  include Sconst

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
      @first = head
      @last = nil
    end

    # Adds a new Body_segment to the body, updating pre and post values
    def add(body_segment)
      # Fix later
      #raise StandardError if body_segment.class != "Snake::Body_segment"

      if @segments.length == 0
        body_segment.update(@first.x, @first.y)
        body_segment.place((@first.x + Sconst::SEG_SPACE),(@first.y + Sconst::SEG_SPACE))
        body_segment.pre = @first
        @segments.append(body_segment)
        @last = body_segment 
      else
        body_segment.update(@last.x, @last.y)
        body_segment.place((@last.x + Sconst::SEG_SPACE),(@last.y + Sconst::SEG_SPACE))
        body_segment.pre = @last
        @segments.append(body_segment)
        @last = body_segment
      end        
    end

    def clear()
      @segments = []
      @last = nil
    end

    # move function alters position of each member
    def move()
      @segments.each do |seg|
        seg.move()
      end
    end

    def draw()
      @segments.each do |s|
        s.draw()
      end
    end

    # Custom enumerable
    def each
      for segment in @segments
        yield(segment)
      end
    end
  end

end

