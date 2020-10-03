# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Bishop
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265d ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All diagonal moves
  def possible_moves(x, y)
    temp = []
    for i in 1..7 do
      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7)
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7)
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7)
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7)
    end
    @moves = temp
  end
end

class White_Bishop
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265d ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All diagonal moves
  def possible_moves(x, y)
    temp = []
    for i in 1..7 do
      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7)
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7)
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7)
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7)
    end
    @moves = temp
  end
end
