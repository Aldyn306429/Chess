# frozen_string_literal: true

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def bpc
    colorize(47)
  end

  def bsc
    colorize(40)
  end
end
  
class Board
  attr_reader :board
  def initialize(pieces)
    @pieces = pieces
    @board = make_board
  end

  def display_board
    @board.join
  end
  
  private

  def make_board
    board = []
    board.push([' ', ' A', ' B', ' C', ' D', ' E', ' F', ' G', ' H', "\n"])
    for i in 0..7
      temp = []
      temp.push("#{i + 1} ")
      for j in 0..7
        temp.push("#{@pieces[i][j]}".bpc) if (i + j).odd?
        temp.push("#{@pieces[i][j]}".bsc) if (i + j).even?
      end
      temp.push("\n")
      board.push(temp)
    end
    board
  end
end

a = Board.new
puts a.display_board
