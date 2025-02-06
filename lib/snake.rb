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

# Velocities for sprite
VELX = 1
VELY = 1

module Snake
  class Window < Gosu::Window
    def initialize()
      super(WINX, WINY, fullscreen: false)
      self.caption = "Snake Game"
      
      #Snake sprite
      
      @icon = Gosu::Image.from_blob(25, 25, "\255\255\255\255" * (25 *25))
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

      if Gosu::button_down?(Gosu::KB_UP)
        @sprite.turn(90)
      elsif Gosu::button_down?(Gosu::KB_DOWN)
        @sprite.turn(270)
      elsif Gosu::button_down?(Gosu::KB_LEFT)
        @sprite.turn(180)
      elsif Gosu::button_down?(Gosu::KB_RIGHT)
        @sprite.turn(0)
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
      if id == Gosu::KB_ESCAPE
        close
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
      

      @head = icon
      @body = Snake_body.new(icon)
    end

    def place(x,y)
      @x = x
      @y = y
    end

    def turn(angle)
      @angle = angle
    end

    def move()
      @x += Gosu::offset_x(@angle, VELX)
      @y += Gosu::offset_y(@angle, VELY)
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
