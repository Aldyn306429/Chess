# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Knight
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265e ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All L-shape moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []
    if (x + 1).between?(0, 7) && (y + 2).between?(0, 7)
      if blocked_moves[x + 1][y + 2] == '  '
        temp.push([x + 1, y + 2])
      else
        temp.push([x + 1, y + 2]) if blocked_moves[x + 1][y + 2].identity != 'black'
      end
    end
    if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)
      if blocked_moves[x - 1][y + 2] == '  '
        temp.push([x - 1, y + 2])
      else
        temp.push([x - 1, y + 2]) if blocked_moves[x - 1][y + 2].identity != 'black'
      end
    end
    if (x + 2).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x + 2][y + 1] == '  '
        temp.push([x + 2, y + 1])
      else
        temp.push([x + 2, y + 1]) if blocked_moves[x + 2][y + 1].identity != 'black'
      end
    end
    if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x - 2][y + 1] == '  '
        temp.push([x - 2, y + 1])
      else
        temp.push([x - 2, y + 1]) if blocked_moves[x - 2][y + 1].identity != 'black'
      end
    end
    if (x - 1).between?(0, 7) && (y - 2).between?(0, 7)
      if blocked_moves[x - 1][y - 2] == '  '
        temp.push([x - 1, y - 2])
      else
        temp.push([x - 1, y - 2]) if blocked_moves[x - 1][y - 2].identity != 'black'
      end
    end
    if (x + 1).between?(0, 7) && (y - 2).between?(0, 7)
      if blocked_moves[x + 1][y - 2] == '  '
        temp.push([x + 1, y - 2])
      else
        temp.push([x + 1, y - 2]) if blocked_moves[x + 1][y - 2].identity != 'black'
      end
    end
    if (x - 2).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x - 2][y - 1] == '  '
        temp.push([x - 2, y - 1])
      else
        temp.push([x - 2, y - 1]) if blocked_moves[x - 2][y - 1].identity != 'black'
      end
    end
    if (x + 2).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x + 2][y - 1] == '  '
        temp.push([x + 2, y - 1])
      else
        temp.push([x + 2, y - 1]) if blocked_moves[x + 2][y - 1].identity != 'black'
      end
    end
    @moves = temp
  end
end

class White_Knight
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265e ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All L-shape moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []
    if (x + 1).between?(0, 7) && (y + 2).between?(0, 7)
      if blocked_moves[x + 1][y + 2] == '  '
        temp.push([x + 1, y + 2])
      else
        temp.push([x + 1, y + 2]) if blocked_moves[x + 1][y + 2].identity != 'white'
      end
    end
    if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)
      if blocked_moves[x - 1][y + 2] == '  '
        temp.push([x - 1, y + 2])
      else
        temp.push([x - 1, y + 2]) if blocked_moves[x - 1][y + 2].identity != 'white'
      end
    end
    if (x + 2).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x + 2][y + 1] == '  '
        temp.push([x + 2, y + 1])
      else
        temp.push([x + 2, y + 1]) if blocked_moves[x + 2][y + 1].identity != 'white'
      end
    end
    if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x - 2][y + 1] == '  '
        temp.push([x - 2, y + 1])
      else
        temp.push([x - 2, y + 1]) if blocked_moves[x - 2][y + 1].identity != 'white'
      end
    end
    if (x - 1).between?(0, 7) && (y - 2).between?(0, 7)
      if blocked_moves[x - 1][y - 2] == '  '
        temp.push([x - 1, y - 2])
      else
        temp.push([x - 1, y - 2]) if blocked_moves[x - 1][y - 2].identity != 'white'
      end
    end
    if (x + 1).between?(0, 7) && (y - 2).between?(0, 7)
      if blocked_moves[x + 1][y - 2] == '  '
        temp.push([x + 1, y - 2])
      else
        temp.push([x + 1, y - 2]) if blocked_moves[x + 1][y - 2].identity != 'white'
      end
    end
    if (x - 2).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x - 2][y - 1] == '  '
        temp.push([x - 2, y - 1])
      else
        temp.push([x - 2, y - 1]) if blocked_moves[x - 2][y - 1].identity != 'white'
      end
    end
    if (x + 2).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x + 2][y - 1] == '  '
        temp.push([x + 2, y - 1])
      else
        temp.push([x + 2, y - 1]) if blocked_moves[x + 2][y - 1].identity != 'white'
      end
    end
    @moves = temp
  end
end
