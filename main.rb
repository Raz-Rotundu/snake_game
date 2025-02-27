# Main script for the snake game
require_relative "lib/snake_win.rb"

def main()
  window = Snake_win::Game_window.new()
  window.show()
end

main()
