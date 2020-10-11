# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_King
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265a ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All surrounding moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []
    if @history.empty?
      if blocked_moves[0][0] != '  '
        if blocked_moves[0][1] == '  ' && blocked_moves[0][2] == '  ' && blocked_moves[0][3] == '  '
          temp.push([0, 2]) if blocked_moves[0][0].history.empty?
        end
      end
      if blocked_moves[0][7] != '  '
        if blocked_moves[0][5] == '  ' && blocked_moves[0][6] == '  '
          temp.push([0, 6]) if blocked_moves[0][7].history.empty?
        end
      end
    end
    if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x - 1][y - 1] == '  '
        temp.push([x - 1, y - 1])
      else
        temp.push([x - 1, y - 1]) if blocked_moves[x - 1][y - 1].identity != 'black'
      end
    end
    if (y - 1).between?(0, 7)
      if blocked_moves[x][y - 1] == '  '
        temp.push([x, y - 1]) 
      else
        temp.push([x, y - 1]) if blocked_moves[x][y - 1].identity != 'black'
      end
    end
    if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x + 1][y - 1] == '  '
        temp.push([x + 1, y - 1])
      else
        temp.push([x + 1, y - 1]) if blocked_moves[x + 1][y - 1].identity != 'black'
      end
    end
    if (x - 1).between?(0, 7)
      if blocked_moves[x - 1][y] == '  '
        temp.push([x - 1, y])
      else
        temp.push([x - 1, y]) if blocked_moves[x - 1][y].identity != 'black'
      end
    end
    if (x + 1).between?(0, 7)
      if blocked_moves[x + 1][y] == '  '
        temp.push([x + 1, y])
      else
        temp.push([x + 1, y]) if blocked_moves[x + 1][y].identity != 'black'
      end
    end
    if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x - 1][y + 1] == '  '
        temp.push([x - 1, y + 1])
      else
        temp.push([x - 1, y + 1]) if blocked_moves[x - 1][y + 1].identity != 'black'
      end
    end
    if (y + 1).between?(0, 7)
      if blocked_moves[x][y + 1] == '  '
        temp.push([x, y + 1])
      else
        temp.push([x, y + 1]) if blocked_moves[x][y + 1].identity != 'black'
      end
    end
    if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x + 1][y + 1] == '  '
        temp.push([x + 1, y + 1])
      else
        temp.push([x + 1, y + 1]) if blocked_moves[x + 1][y + 1].identity != 'black'
      end
    end
    @moves = temp
  end
end

class White_King
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265a ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All surrounding moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []
    if @history.empty?
      if blocked_moves[7][0] != '  '
        if blocked_moves[7][1] == '  ' && blocked_moves[7][2] == '  ' && blocked_moves[7][3] == '  '
          temp.push([7, 2]) if blocked_moves[7][0].history.empty?
        end
      end
      if blocked_moves[7][7] != '  '
        if blocked_moves[7][5] == '  ' && blocked_moves[7][6] == '  '
          temp.push([7, 6]) if blocked_moves[7][7].history.empty?
        end
      end
    end
    if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x - 1][y - 1] == '  '
        temp.push([x - 1, y - 1])
      else
        temp.push([x - 1, y - 1]) if blocked_moves[x - 1][y - 1].identity != 'white'
      end
    end
    if (y - 1).between?(0, 7)
      if blocked_moves[x][y - 1] == '  '
        temp.push([x, y - 1]) 
      else
        temp.push([x, y - 1]) if blocked_moves[x][y - 1].identity != 'white'
      end
    end
    if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
      if blocked_moves[x + 1][y - 1] == '  '
        temp.push([x + 1, y - 1])
      else
        temp.push([x + 1, y - 1]) if blocked_moves[x + 1][y - 1].identity != 'white'
      end
    end
    if (x - 1).between?(0, 7)
      if blocked_moves[x - 1][y] == '  '
        temp.push([x - 1, y])
      else
        temp.push([x - 1, y]) if blocked_moves[x - 1][y].identity != 'white'
      end
    end
    if (x + 1).between?(0, 7)
      if blocked_moves[x + 1][y] == '  '
        temp.push([x + 1, y])
      else
        temp.push([x + 1, y]) if blocked_moves[x + 1][y].identity != 'white'
      end
    end
    if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x - 1][y + 1] == '  '
        temp.push([x - 1, y + 1])
      else
        temp.push([x - 1, y + 1]) if blocked_moves[x - 1][y + 1].identity != 'white'
      end
    end
    if (y + 1).between?(0, 7)
      if blocked_moves[x][y + 1] == '  '
        temp.push([x, y + 1])
      else
        temp.push([x, y + 1]) if blocked_moves[x][y + 1].identity != 'white'
      end
    end
    if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)
      if blocked_moves[x + 1][y + 1] == '  '
        temp.push([x + 1, y + 1])
      else
        temp.push([x + 1, y + 1]) if blocked_moves[x + 1][y + 1].identity != 'white'
      end
    end
    @moves = temp
  end
end
