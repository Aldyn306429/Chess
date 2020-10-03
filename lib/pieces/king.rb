# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_King
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265a ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All surrounding moves
  def possible_moves(x, y)
    temp = []
    temp.push([x - 1, y - 1]) if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x, y - 1]) if (y - 1).between?(0, 7)
    temp.push([x + 1, y - 1]) if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x - 1, y]) if (x - 1).between?(0, 7)
    temp.push([x + 1, y]) if (x + 1).between?(0, 7)
    temp.push([x - 1, y + 1]) if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x, y + 1]) if (y + 1).between?(0, 7)
    temp.push([x + 1, y + 1]) if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)
    @moves = temp
  end
end

class White_king
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265a ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All surrounding moves
  def possible_moves(x, y)
    temp = []
    temp.push([x - 1, y - 1]) if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x, y - 1]) if (y - 1).between?(0, 7)
    temp.push([x + 1, y - 1]) if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x - 1, y]) if (x - 1).between?(0, 7)
    temp.push([x + 1, y]) if (x + 1).between?(0, 7)
    temp.push([x - 1, y + 1]) if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x, y + 1]) if (y + 1).between?(0, 7)
    temp.push([x + 1, y + 1]) if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)
    @moves = temp
  end
end
