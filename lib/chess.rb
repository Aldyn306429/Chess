# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'game_master.rb'
require_relative 'player.rb'
require_relative 'save.rb'
require_relative 'string.rb'

class Game
  include Clean_String
  include Game_Rules

  attr_reader :board
  def initialize
    pieces = Pieces.new
    @victory = false
    @board = Board.new(pieces.pieces_pos)
    intro
  end

  def intro
    # start_game
  end

  def start_game
    i = 0
    until @victory
      i += 1
      puts @board.display_board
      puts 'Make a move'
      response = gets.chomp
      until make_move(response)
        puts 'Make a move'
        response = gets.chomp
      end
      @victory = true if i == 4
    end
  end

  def make_move(string)
    string = string.split(':')
    start_pos = translate(string[0].strip)
    end_pos = translate(string[1].strip)
    if check_string(end_pos) || check_string(start_pos)
      puts 'Piece not in the board'
      return false 
    end
    if illegal?(@board.pieces[start_pos[1]][start_pos[0]].possible_moves(start_pos[1], start_pos[0]), [end_pos[1], end_pos[0]])
      puts 'Illegal move'
      return false 
    end
    @board.pieces[end_pos[1]][end_pos[0]] = @board.pieces[start_pos[1]][start_pos[0]]
    @board.pieces[start_pos[1]][start_pos[0]].history.push("#{string[0].strip} -> #{string[1].strip}")
    @board.pieces[start_pos[1]][start_pos[0]] = '  '
    @board.make_board
  end
end

Game.new