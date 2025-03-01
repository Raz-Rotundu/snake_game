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
      color == nil ? @icon.draw(@x - @icon.width/2, @y - @icon.width/2, @z, 1, 1) : @icon.draw(@x - @icon.width/2, @y - @icon.height/2, @z, 1, 1,color, :additive)
    end

    def to_s()
      return "X: #{@x}, Y: #{@y}"
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
    
    # A sprite with a hardcoded Green square icon
    class Snake_segment < Sprite
      def initialize()
        @square = Gosu::Image.from_blob(25,25, Sconst::GREEN_HEX * (25 * 25))
        super(@square)
      end
    end
      
        # A sprite with position and direction
    class Snake_head < Snake_segment
      attr_accessor :direction

      def initialize()
        @direction = 'u'
        super()
      end

      def move()
        case @direction
        when 'u'
          @y -= Sconst::VEL

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
        return Gosu::distance(self.x, self.y, obj.x, obj.y) < Sconst::TOUCH_DIST
      end

      def turn(d)
        @direction = d
      end

      def to_s()
        s = super()
        return s + " Direction: #{@direction}"
      end
    end

      # A body segment tracking the position of the segments ahead and behind it
    class Body_segment < Snake_head
      attr_accessor :pre, :post, :pre_x, :pre_y

      def initialize()
        @pre = nil
        @post = nil
        @pre_x = 0
        @pre_y = 0
        super()
      end

      def update(x,y)
        @pre_x = x
        @pre_y = y
      end

      def move()
        @x = @pre_x
        @y = @pre_y
        
        @pre_x = @pre.x
        @pre_y = @pre.y
      end

      def to_s()
        s = super()
        return s + " Pre: #{@pre}, Post: #{@post}"
      end
    end

    #TODO Class containing head, body and control functions
    class Snake_sprite
      attr_reader :direction, :score

      def initialize()
        @head = Snake_head.new()
        @body = Scollect::Snake_Body.new(@head)
        @direction = 'u'
        @score = 0
      end

      def move()
        @head.move()
        @body.move()
      end

      def place(x, y)
        @head.place(x,y)
      end

      def draw()
        @head.draw()
        @body.draw()
      end

      def is_touching?(obj)
        return @head.is_touching?(obj)
      end

      def eat_star(collection)
        collection.reject! do |star|
          if self.is_touching?(star)
            @score += 1
            @body.add(Body_segment.new())
            true
          else
            false
          end
        end
      end

      def turn(d)
        @direction = d
        @head.turn(d)
      end


      #TODO function to check if snake is touching itself
      def self_touch?()
        @body.each do |s|
          if Gosu::distance(@head.x, @head.y, s.x, s.y) == 0
            return true
          end
        end
        return false
      end


      def reset()
        @score = 0
        @body.clear()
        @head.place(Sconst::WINX/2, Sconst::WINY/2)
      end
    end 

  end
