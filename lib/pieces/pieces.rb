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

class Pieces
  attr_accessor :pieces_pos
  def initialize
    @pieces_pos = [
    [Black_Rook.new, Black_Knight.new, Black_Bishop.new, Black_Queen.new, Black_King.new, Black_Bishop.new, Black_Knight.new, Black_Rook.new], 
    [Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new], 
    ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
    ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
    ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
    ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
    [White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new], 
    [White_Rook.new, White_Knight.new, White_Bishop.new, White_Queen.new, White_King.new, White_Bishop.new, White_Knight.new, White_Rook.new]]
  end
end