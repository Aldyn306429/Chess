# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Bishop
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265d ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  # All diagonal moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # To prevent pieces from going through other pieces
    testDia1 = true
    testDia2 = true
    testDia3 = true
    testDia4 = true

    for i in 1..7 do
      if !blocked_moves.nil?
        if (x - i).between?(0, 7) && (y - i).between?(0, 7) && blocked_moves[x - i][y - i] != '  '
          temp.push([x - i, y - i]) if blocked_moves[x - i][y - i].identity == 'white' && testDia1 == true
          testDia1 = false
        end
        if (x + i).between?(0, 7) && (y + i).between?(0, 7) && blocked_moves[x + i][y + i] != '  '
          temp.push([x + i, y + i]) if blocked_moves[x + i][y + i].identity == 'white' && testDia2 == true
          testDia2 = false
        end
        if (x - i).between?(0, 7) && (y + i).between?(0, 7) && blocked_moves[x - i][y + i] != '  '
          temp.push([x - i, y + i]) if blocked_moves[x - i][y + i].identity == 'white' && testDia3 == true
          testDia3 = false
        end
        if (x + i).between?(0, 7) && (y - i).between?(0, 7) && blocked_moves[x + i][y - i] != '  '
          temp.push([x + i, y - i]) if blocked_moves[x + i][y - i].identity == 'white' && testDia4 == true
          testDia4 = false
        end
      end

      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7) && testDia1
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7) && testDia2
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7) && testDia3
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7) && testDia4
    end
    @moves = temp
  end
end

class White_Bishop
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265d ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  # All diagonal moves
  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # To prevent pieces from going through other pieces
    testDia1 = true
    testDia2 = true
    testDia3 = true
    testDia4 = true

    for i in 1..7 do
      if !blocked_moves.nil?
        if (x - i).between?(0, 7) && (y - i).between?(0, 7) && blocked_moves[x - i][y - i] != '  '
          temp.push([x - i, y - i]) if blocked_moves[x - i][y - i].identity == 'black' && testDia1 == true
          testDia1 = false
        end
        if (x + i).between?(0, 7) && (y + i).between?(0, 7) && blocked_moves[x + i][y + i] != '  '
          temp.push([x + i, y + i]) if blocked_moves[x + i][y + i].identity == 'black' && testDia2 == true
          testDia2 = false
        end
        if (x - i).between?(0, 7) && (y + i).between?(0, 7) && blocked_moves[x - i][y + i] != '  '
          temp.push([x - i, y + i]) if blocked_moves[x - i][y + i].identity == 'black' && testDia3 == true
          testDia3 = false
        end
        if (x + i).between?(0, 7) && (y - i).between?(0, 7) && blocked_moves[x + i][y - i] != '  '
          temp.push([x + i, y - i]) if blocked_moves[x + i][y - i].identity == 'black' && testDia4 == true
          testDia4 = false
        end
      end

      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7) && testDia1
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7) && testDia2
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7) && testDia3
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7) && testDia4
    end
    @moves = temp
  end
end
