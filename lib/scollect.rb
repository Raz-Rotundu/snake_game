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
        body_segment.place((@first.x + 10),(@first.y + 10))
        body_segment.pre = @first
        body_segment.direction = @first.direction
        @segments.append(body_segment)
        @last = body_segment 
      else
        body_segment.place((@last.x + 10),(@last.y + 10))
        body_segment.pre = @last
        body_segment.direction = @last.direction
        @segments.append(body_segment)
        @last = body_segment
      end        
      #TODO remove this
      puts(@last)
    end

    def clear()
      @segments = []
      @last = nil
    end

    #TODO move function alters position of each member
    def move()
      @segments.each do |seg|
        seg.place((seg.pre.x),(seg.pre.y))
      end
    end

    def draw()
      @segments.each do |s|
        s.draw()
      end
    end
  end

end

