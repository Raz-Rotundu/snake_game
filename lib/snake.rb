# Module for the snake window, sprite, and food classes

require 'gosu'

#Window parameters
WINX = 750
WINY = 750

# Z orderings
ZBKG = 0
ZFOOD, ZSPRITE = 1

# Image locations
FOODIMG = "media/star.png"
BKGIMG = "media/grass_background.png"


module Snake
  class Window < Gosu::Window
    def initialize()
      super(WINX, WINY, fullscreen: false)
      self.caption = "Snake Game"
      
      @background = Gosu::Image.new(BKGIMG, tileable: true)

      #Food pellets
      @pellets = []
      @animation = Animation.new()

    end

    def update()
      if rand(100) < 4 and @pellets.length < 25
        @pellets.push(Food.new(@animation))
      end

    end

    def draw()
      @background.draw(0,0,ZBKG, 2.5, 2.5)
      @pellets.each do |pellet|
        pellet.draw()
      end

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
      img.draw(@x, @y, @z)
    end

  end

  class Sprite

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
