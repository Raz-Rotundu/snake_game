# Module for the snake window, sprite, and food classes

require 'gosu'

#Window parameters
WINX = 750
WINY = 750

# Z orderings
ZBKG = 0
ZFOOD = ZSPRITE = ZTEXT = 1

# Image locations
FOODIMG = "media/star.png"
BKGIMG = "media/grass_background.png"

# Font sizes for sprites and text
SPRITESIZE = 12
FONTSIZE = 24

# Velocity for sprite
VEL = 2


module Snake
  class Window < Gosu::Window
    def initialize()
      super(WINX, WINY, fullscreen: false)
      self.caption = "Snake Game"
      
      # Score caption
      @score = Gosu::Font.new(50)

      #Snake sprite
      @icon = Gosu::Image.from_blob(25, 25, "\0\xFF\0\xFF" * (25 * 25))
      @sprite = Snake.new(@icon)
      @sprite.place(WINX/2, WINY/2)

      #Food pellets
      @pellets = []
      @animation = Animation.new()

    end

    def update()
      if rand(100) < 4 and @pellets.length < 25
        @pellets.push(Food.new(@animation))
      end


      @sprite.move()

    end

    def draw()
      @pellets.each do |pellet|
        pellet.draw()
      end

      @sprite.draw()
      @sprite.eat_food(@pellets)

      @score.draw_text("Current Score: #{@sprite.get_length} ", 0, 0, ZTEXT)

    end

    def button_down(id)
      case id
      when Gosu::KB_UP
        @sprite.turn('u')
      when Gosu::KB_DOWN
        @sprite.turn('d')
      when Gosu::KB_RIGHT
        @sprite.turn('r')
      when Gosu::KB_LEFT
        @sprite.turn('l')
      when Gosu::KB_ESCAPE
        close()
      else
       super()
      end
    end

  end

  class Food
    attr_reader :x, :y

    def initialize(a)
      @animation = a

      # Top left 50x50 reserved for scorecard
      @x = rand(50..WINX)
      @y = rand(50..WINY)
      @z = ZFOOD
    end

    def draw()
      img = @animation.frame()
      img.draw(@x, @y, @z, 1, 1, Gosu::Color::YELLOW.dup, :additive)
    end

  end

  class Snake
    def initialize(icon)
      @x = @y = @angle = @length = 0.0
      @z = ZSPRITE
      @dir = 'u'
      

      @head = icon
      @body = Snake_body.new(icon)
    end

    def place(x,y)
      @x = x
      @y = y
    end

    def turn(d)
      @dir = d
    end

    def move()
      case @dir
      when 'u'
        @y -= VEL
      when 'd'
        @y += VEL
      when 'r'
        @x += VEL
      when 'l'
        @x -= VEL
      end
    end

    def eat_food(pellets)
      pellets.reject! do |p|
        if  Gosu::distance(@x, @y, p.x, p.y) < 35
          #Modify body
          @body.grow()
          true
        else
          false
        end
      end
    end

    def get_length()
      return @body.length
    end

    def draw()
      @head.draw(@x, @y, ZSPRITE, 1, 1) 

    end
  end

  class Snake_body
    attr_reader :length

    def initialize(icon)
      @length = 0
      
    end

    def grow()
      @length += 1
    end


  end
  class Animation
    def initialize
      @frames = Gosu::Image.load_tiles(FOODIMG, 25, 25)
    end
  
    def frame()
      frame = @frames[(Gosu::milliseconds / 100) % @frames.length]
      return frame
    end

  end
end
