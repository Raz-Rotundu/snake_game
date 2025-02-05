# Main script for the snake game
require_relative "lib/snake.rb"

def main()
  window = Snake::Window.new()
  window.show()
end

main()
