# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Pawn
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265f ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # One-step and two-step moves
  def possible_moves(x, y)
    temp = []
    temp.push([x, y + 1]) if (y + 1).between?(0, 7)
    temp.push([x, y + 2]) if @history.empty?
    @moves = temp
  end
end

class White_Pawn
  attr_accessor :piece, :history
  attr_reader :moves
  def initialize
    @piece = "\u265f ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # One-step and two-step moves
  def possible_moves(x, y)
    temp = []
    temp.push([x, y - 1]) if (y - 1).between?(0, 7)
    temp.push([x, y - 2]) if @history.empty?
    @moves = temp
  end
end
