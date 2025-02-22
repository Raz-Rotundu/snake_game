require 'gosu'
require_relative 'scollect'
require_relative 'sconst'

module Snake
  include Sconst
  include Scollect

  # A static image with a position
  class Sprite
    def init(image)
      @icon = image
      @x = @y = 0
      @z = Sconst::SPRITEZ
    end

    def place(x, y)
      @x = x
      @y = y
    end

    def draw()
      @icon.draw(@x, @y, @z)
    end


    # A sprite using an animation
    class Star < Sprite
      # some sort of include statement?

      def init(anim)
        @animation = anim
        super(@animation.next())
      end

      def draw()
        @icon = @animation.next()
        super()
      end
    end

    # A sprite with position and direction
    class Snake_head < Sprite
      def init(icon)
        @direction = 'U'
        super(icon)
      end

      def is_touching?(obj)
        return Gosu::distance(self.x, self.y, obj.x, obj.y) < 35
      end
    end
  end
