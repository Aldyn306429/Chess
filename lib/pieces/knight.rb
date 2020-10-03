# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Knight
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265e ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All L-shape moves
  def possible_moves(x, y)
    temp = []
    temp.push([x + 1, y + 2]) if (x + 1).between?(0, 7) && (y + 2).between?(0, 7)
    temp.push([x - 1, y + 2]) if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)
    temp.push([x + 2, y + 1]) if (x + 2).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x - 2, y + 1]) if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x - 1, y - 2]) if (x - 1).between?(0, 7) && (y - 2).between?(0, 7)
    temp.push([x + 1, y - 2]) if (x + 1).between?(0, 7) && (y - 2).between?(0, 7)
    temp.push([x - 2, y - 1]) if (x - 2).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x + 2, y - 1]) if (x + 2).between?(0, 7) && (y - 1).between?(0, 7)
    @moves = temp
  end
end

class White_Knight
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265e ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All L-shape moves
  def possible_moves(x, y)
    temp = []
    temp.push([x + 1, y + 2]) if (x + 1).between?(0, 7) && (y + 2).between?(0, 7)
    temp.push([x - 1, y + 2]) if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)
    temp.push([x + 2, y + 1]) if (x + 2).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x - 2, y + 1]) if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)
    temp.push([x - 1, y - 2]) if (x - 1).between?(0, 7) && (y - 2).between?(0, 7)
    temp.push([x + 1, y - 2]) if (x + 1).between?(0, 7) && (y - 2).between?(0, 7)
    temp.push([x - 2, y - 1]) if (x - 2).between?(0, 7) && (y - 1).between?(0, 7)
    temp.push([x + 2, y - 1]) if (x + 2).between?(0, 7) && (y - 1).between?(0, 7)
    @moves = temp
  end
end
