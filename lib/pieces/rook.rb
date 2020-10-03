# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Rook
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265c ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  def possible_moves(x, y)
    temp = []

    # Horizontal and vertical possible moves
    for i in 1..7 do
      temp.push([x, y - i]) if (y - i).between?(0, 7)
      temp.push([x, y + i]) if (y + i).between?(0, 7)
      temp.push([x - i, y]) if (x - i).between?(0, 7)
      temp.push([x + i, y]) if (x + i).between?(0, 7)
    end
    @moves = temp
  end
end

class White_Rook
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265c ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  def possible_moves(x, y)
    temp = []

    # Horizontal and vertical possible moves
    for i in 1..7 do
      temp.push([x, y - i]) if (y - i).between?(0, 7)
      temp.push([x, y + i]) if (y + i).between?(0, 7)
      temp.push([x - i, y]) if (x - i).between?(0, 7)
      temp.push([x + i, y]) if (x + i).between?(0, 7)
    end
    @moves = temp
  end
end
