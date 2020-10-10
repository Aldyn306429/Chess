# frozen_string_literal: true

require_relative 'pieces.rb'

class Black_Queen
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265b ".dark_piece
    @moves = []
    @history = []
    @identity = 'black'
  end

  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # To prevent pieces from going through other pieces
    testDia1 = true
    testDia2 = true
    testDia3 = true
    testDia4 = true
    test1 = true # For going left
    test2 = true # For going right
    test3 = true # For going up
    test4 = true # For going down

    # Horizontal, vertical, and all diagonal possible moves
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
        if (y - i).between?(0, 7) && blocked_moves[x][y - i] != '  '
          temp.push([x, y - i]) if blocked_moves[x][y - i].identity == 'white' && test1 == true
          test1 = false
        end
        if (y + i).between?(0, 7) && blocked_moves[x][y + i] != '  '
          temp.push([x, y + i]) if blocked_moves[x][y + i].identity == 'white' && test2 == true
          test2 = false
        end
        if (x - i).between?(0, 7) && blocked_moves[x - i][y] != '  '
          temp.push([x - i, y]) if blocked_moves[x - i][y].identity == 'white' && test3 == true
          test3 = false
        end
        if (x + i).between?(0, 7) && blocked_moves[x + i][y] != '  '
          temp.push([x + i, y]) if blocked_moves[x + i][y].identity == 'white' && test4 == true
          test4 = false
        end
      end

      temp.push([x, y - i]) if (y - i).between?(0, 7) && test1
      temp.push([x, y + i]) if (y + i).between?(0, 7) && test2
      temp.push([x - i, y]) if (x - i).between?(0, 7) && test3
      temp.push([x + i, y]) if (x + i).between?(0, 7) && test4
      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7) && testDia1
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7) && testDia2
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7) && testDia3
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7) && testDia4
    end
    @moves = temp
  end
end

class White_Queen
  attr_accessor :piece, :history
  attr_reader :moves, :identity
  def initialize
    @piece = "\u265b ".light_piece
    @moves = []
    @history = []
    @identity = 'white'
  end

  def possible_moves(x, y, blocked_moves = nil)
    temp = []

    # To prevent pieces from going through other pieces
    testDia1 = true
    testDia2 = true
    testDia3 = true
    testDia4 = true
    test1 = true # For going left
    test2 = true # For going right
    test3 = true # For going up
    test4 = true # For going down

    # Horizontal, vertical, and all diagonal possible moves
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
        if (y - i).between?(0, 7) && blocked_moves[x][y - i] != '  '
          temp.push([x, y - i]) if blocked_moves[x][y - i].identity == 'black' && test1 == true
          test1 = false
        end
        if (y + i).between?(0, 7) && blocked_moves[x][y + i] != '  '
          temp.push([x, y + i]) if blocked_moves[x][y + i].identity == 'black' && test2 == true
          test2 = false
        end
        if (x - i).between?(0, 7) && blocked_moves[x - i][y] != '  '
          temp.push([x - i, y]) if blocked_moves[x - i][y].identity == 'black' && test3 == true
          test3 = false
        end
        if (x + i).between?(0, 7) && blocked_moves[x + i][y] != '  '
          temp.push([x + i, y]) if blocked_moves[x + i][y].identity == 'black' && test4 == true
          test4 = false
        end
      end

      temp.push([x, y - i]) if (y - i).between?(0, 7) && test1
      temp.push([x, y + i]) if (y + i).between?(0, 7) && test2
      temp.push([x - i, y]) if (x - i).between?(0, 7) && test3
      temp.push([x + i, y]) if (x + i).between?(0, 7) && test4
      temp.push([x - i, y - i]) if (x - i).between?(0, 7) && (y - i).between?(0, 7) && testDia1
      temp.push([x + i, y + i]) if (x + i).between?(0, 7) && (y + i).between?(0, 7) && testDia2
      temp.push([x - i, y + i]) if (x - i).between?(0, 7) && (y + i).between?(0, 7) && testDia3
      temp.push([x + i, y - i]) if (x + i).between?(0, 7) && (y - i).between?(0, 7) && testDia4
    end
    @moves = temp
  end
end
