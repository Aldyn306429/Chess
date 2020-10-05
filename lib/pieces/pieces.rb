# frozen_string_literal: true

require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'
require_relative 'knight.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'

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
