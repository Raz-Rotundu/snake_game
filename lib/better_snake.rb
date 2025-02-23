require 'gosu'
require_relative 'scollect'
require_relative 'sconst'

module Snake
  include Sconst
  include Scollect

  # A static image with a position
  class Sprite
    attr_reader :x, :y

    # Gosu::Image
    def initialize(image, x = 0, y = 0)
      @icon = image
      @x = x
      @y = y
      @z = Sconst::SPRITEZ
    end

    def place(x, y)
      @x = x
      @y = y
    end

    def draw(color)
      color == nil ? @icon.draw(@x, @y, @z, 1, 1) : @icon.draw(@x, @y, @z, 1, 1,color, :additive)
    end


    # A sprite using an animation
    class Star < Sprite
      # Scollect::Animation
      def initialize(anim)
        @animation = anim
        super(@animation.next(), rand(50..Sconst::WINX), rand(50..Sconst::WINY))
      end

      def draw()
        self.icon = @animation.next()
        super(Gosu::Color::YELLOW.dup)
      end
    end

    # A sprite with position and direction
    class Snake_head < Sprite

      def initialize(icon)
        @direction = 'u'
        super(icon)
      end

      def is_touching?(obj)
        return Gosu::distance(self.x, self.y, obj.x, obj.y) < 35
      end
    end
  end
