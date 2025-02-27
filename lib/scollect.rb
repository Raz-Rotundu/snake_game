# Collections of things for the snake game

require 'gosu'
require_relative 'sconst.rb'
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
    def initialize()
      @segments = []
      @first = @last = nil
    end

    # TODO add object behaviour
    def add(o)
    end

    def clear()
      @segments = []
      @first = @last = nil
    end

    def draw()
      @segments.each do |s|
        s.draw()
      end
    end
  end

end

