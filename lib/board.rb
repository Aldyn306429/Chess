# frozen_string_literal: true

require_relative 'pieces/pieces.rb'

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
  attr_accessor :pieces
  def initialize(pieces)
    @pieces = pieces
    make_board
  end

  def display_board
    @board.join
  end
  
  def make_board
    board = []
    board.push([' ', ' A', ' B', ' C', ' D', ' E', ' F', ' G', ' H', "\n"])
    for i in 0..7
      temp = []
      temp.push("#{8 - i} ")
      for j in 0..7
        if (i + j).odd? && @pieces[i][j] != '  '
          temp.push("#{@pieces[i][j].piece}".bsc) 
        elsif (i + j).odd?
          temp.push('  '.bsc)
        end
        if (i + j).even? && @pieces[i][j] != '  '
          temp.push("#{@pieces[i][j].piece}".bpc)
        elsif (i + j).even?
          temp.push('  '.bpc)
        end
      end
      temp.push(" #{8 - i}")
      temp.push("\n")
      board.push(temp)
    end
    board.push(['  ', ' A', ' B', ' C', ' D', ' E', ' F', ' G', ' H', "\n"])
    @board = board
  end
end
