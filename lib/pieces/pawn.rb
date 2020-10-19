# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Pawn
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  attr_writer :passantL, :passantR
  def initialize
    @piece = "\u265f ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
    @passantL = false
    @passantR = false
  end

  # One-step and two-step moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # For En Passant
    if @passantR
      temp.push([x + 1, y + 1]) if blocked_moves[x][y + 1].piece == "\u265f ".light_piece && @passantR
      @passantR = false
    end
    if @passantL
      temp.push([x + 1, y - 1]) if blocked_moves[x][y - 1].piece == "\u265f ".light_piece && @passantL
      @passantL = false
    end

    # To take enemy pieces diagonally
    if (x + 1).between?(0, 7) && (y + 1).between?(0, 7) && blocked_moves[x + 1][y + 1] != '  '
      temp.push([x + 1, y + 1]) if blocked_moves[x + 1][y + 1].identity == 'white'
      @moves.push([x + 1, y + 1]) if blocked_moves[x + 1][y + 1].identity == 'white'
    end
    if (x + 1).between?(0, 7) && (y - 1).between?(0, 7) && blocked_moves[x + 1][y - 1] != '  '
      temp.push([x + 1, y - 1]) if blocked_moves[x + 1][y - 1].identity == 'white'
      @moves.push([x + 1, y - 1]) if blocked_moves[x + 1][y - 1].identity == 'white'
    end

    if (x + 1).between?(0, 7)
      temp.push([x + 1, y]) if blocked_moves[x + 1][y] == '  '
    end
    temp.push([x + 2, y]) if @history.empty? && blocked_moves[x + 2][y] == '  ' && blocked_moves[x + 1][y] == '  '
    moves = temp
  end
end

class White_Pawn
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  attr_writer :passantL, :passantR
  def initialize
    @piece = "\u265f ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
    @passantR = false
    @passantL = false
  end

  # One-step and two-step moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # For En Passant
    if @passantR
      temp.push([x - 1, y + 1]) if blocked_moves[x][y + 1].piece == "\u265f ".dark_piece && @passantR
      @passantR = false
    end
    if @passantL
      temp.push([x - 1, y - 1]) if blocked_moves[x][y - 1].piece == "\u265f ".dark_piece && @passantL
      @passantL = false
    end

    # To take enemy pieces diagonally
    if (x - 1).between?(0, 7) && (y + 1).between?(0, 7) && blocked_moves[x - 1][y + 1] != '  '
      temp.push([x - 1, y + 1]) if blocked_moves[x - 1][y + 1].identity == 'black'
    end
    if (x - 1).between?(0, 7) && (y - 1).between?(0, 7) && blocked_moves[x - 1][y - 1] != '  '
      temp.push([x - 1, y - 1]) if blocked_moves[x - 1][y - 1].identity == 'black'
    end

    if (x - 1).between?(0, 7)
      temp.push([x - 1, y]) if blocked_moves[x - 1][y] == '  '
    end
    temp.push([x - 2, y]) if @history.empty? && blocked_moves[x - 2][y] == '  ' && blocked_moves[x - 1][y] == '  '
    @moves = temp
  end
end
