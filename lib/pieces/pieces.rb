# frozen_string_literal: true

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  
  def dark_piece
    colorize(34)
  end
  
  def light_piece
    colorize(36)
  end
end
