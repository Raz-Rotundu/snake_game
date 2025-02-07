# Module for the snake window, sprite, and food classes

require 'gosu'

#Window parameters
WINX = 750
WINY = 750

# Z orderings
ZBKG = 0
ZFOOD = ZSPRITE = 1

# Image locations
FOODIMG = "media/star.png"
BKGIMG = "media/grass_background.png"

# Font sizes for sprites and text
SPRITESIZE = 12
FONTSIZE = 24

# Velocity for sprite
VEL = 1

module Snake
  class Window < Gosu::Window
    def initialize()
      super(WINX, WINY, fullscreen: false)
      self.caption = "Snake Game"
      
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

    def draw()
      @head.draw(@x, @y, ZSPRITE, 1, 1) 

    end
  end

  class Snake_body
    def initialize(icon)

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
