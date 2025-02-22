# Collections of things for the snake game

require 'gosu'
module Scollect
  include Sconst

  # Collection of animation frames + api
  class Animation
    def init
      @frames = Gosu::Image.load_tiles(Sconst::FOODIMG, Sconst::FOODX, Sconst::FOODY)
    end

    def next()
      return @frames[(Gosu::Milliseconds / Sconst::REFRESH) % @frames.length()]
    end
  end

  # A collection of snake body segments + api
  class Snake_Body
    def init()
      @segments = []
      @first = @last = nil
    end

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

