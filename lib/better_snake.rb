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
      @z = Sconst::ZSPRITE
    end

    def place(x, y)
      @x = x
      @y = y
    end

    def draw(color = nil)
      color == nil ? @icon.draw_rot(@x, @y, @z, 1, 1) : @icon.draw(@x, @y, @z, 1, 1,color, :additive)
    end
  end


    # A sprite using an animation
    class Star < Sprite
      # Scollect::Animation
      def initialize(anim)
        @animation = anim
        super(@animation.next(), rand(Sconst::SCORE_SIZE..Sconst::WINX), rand(Sconst::SCORE_SIZE..Sconst::WINY))
      end

      def draw()
        @icon = @animation.next()
        super(Gosu::Color::YELLOW.dup)
      end
    end

    # A sprite with position and direction
    class Snake_head < Sprite
      attr_accessor :direction

      def initialize(icon)
        @direction = 'u'
        super(icon)
      end

      def move()
        case @direction
        when 'u'
          @y += Sconst::VEL

        when 'd'
          @y += Sconst::VEL

        when 'l'
          @x -= Sconst::VEL

        when 'r'
          @x += Sconst::VEL

        end
        @x %= Sconst::WINX
        @y %= Sconst::WINY
      end

      def is_touching?(obj)
        return Gosu::distance(self.x, self.y, obj.x, obj.y) < 35
      end
    end

    class Snake_sprite

      def initialize(icon)
        @head = Snake_head.new(icon) 
        @body = 
  end
