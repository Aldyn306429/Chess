# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'game_master.rb'
require_relative 'player.rb'
require_relative 'save.rb'
require_relative 'string.rb'

class Game
  include Clean_String
  include Game_Rules

  attr_reader :board, :king_in_check
  def initialize
    pieces = Pieces.new
    @victory = false
    @game_over = false
    @board = Board.new(pieces.pieces_pos)
    @king_in_check = false
    intro
  end

  def intro
    start_game
    # for i in 0..7
    #   for j in 0..7
    #     if @board.pieces[i][j] != '  '
    #       p @board.pieces[i][j].possible_moves(i, j, @board.pieces)
    #     end
    #   end
    # end
  end

  def start_game
    until @game_over
      puts @board.display_board
      puts 'Make a move'
      response = gets.chomp
      until make_move(response)
        puts 'Make a move'
        response = gets.chomp
      end
    end
  end

  def make_move(string, side = nil)
    string = string.split(':')
    start_pos = translate(string[0].strip)
    end_pos = translate(string[1].strip)
    if @board.pieces[start_pos[1]][start_pos[0]] == '  '
      puts 'No piece selected'
      return false
    end
    if check_string(end_pos) || check_string(start_pos)
      puts 'Piece not in the board'
      return false 
    end
    if illegal?(@board.pieces[start_pos[1]][start_pos[0]].possible_moves(start_pos[1], start_pos[0], @board.pieces), [end_pos[1], end_pos[0]])
      puts 'Illegal move'
      return false 
    end
    
    @board.pieces[start_pos[1]][start_pos[0]].history.push("#{string[0].strip} : #{string[1].strip}")

    # To get rid of En Passant
    for i in 0..7
      for j in 0..7
        if @board.pieces[i][j] != '  '
          @board.pieces[i][j].possible_moves(i, j, @board.pieces)
        end
      end
    end

    # To add En Passant to pawns
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265f ".light_piece && end_pos[1] - start_pos[1] == -2
      if @board.pieces[start_pos[1]][start_pos[0]].history.length == 1
        if @board.pieces[end_pos[1]][end_pos[0] - 1] != '  ' && (end_pos[0] - 1).between?(0, 7)
          @board.pieces[end_pos[1]][end_pos[0] - 1].passantR = true if @board.pieces[end_pos[1]][end_pos[0] - 1].piece == "\u265f ".dark_piece
        end
        if @board.pieces[end_pos[1]][end_pos[0] + 1] != '  ' && (end_pos[0] + 1).between?(0, 7)
          @board.pieces[end_pos[1]][end_pos[0] + 1].passantL = true if @board.pieces[end_pos[1]][end_pos[0] + 1].piece == "\u265f ".dark_piece
        end
      end
    end
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265f ".dark_piece && end_pos[1] - start_pos[1] == 2
      if @board.pieces[start_pos[1]][start_pos[0]].history.length == 1
        if @board.pieces[end_pos[1]][end_pos[0] - 1] != '  ' && (end_pos[0] - 1).between?(0, 7)
          @board.pieces[end_pos[1]][end_pos[0] - 1].passantR = true if @board.pieces[end_pos[1]][end_pos[0] - 1].piece == "\u265f ".light_piece
        end
        if @board.pieces[end_pos[1]][end_pos[0] + 1] != '  ' && (end_pos[0] + 1).between?(0, 7)
          @board.pieces[end_pos[1]][end_pos[0] + 1].passantL = true if @board.pieces[end_pos[1]][end_pos[0] + 1].piece == "\u265f ".light_piece
        end
      end
    end

    # When Executing En Passant
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265f ".light_piece
      if end_pos[0] - start_pos[0] == 1 && end_pos[1] - start_pos[1] == -1 && @board.pieces[end_pos[1]][end_pos[0]] == '  '
        @board.pieces[start_pos[1]][start_pos[0] + 1] = '  '
      end
      if end_pos[0] - start_pos[0] == -1 && end_pos[1] - start_pos[1] == -1 && @board.pieces[end_pos[1]][end_pos[0]] == '  '
        @board.pieces[start_pos[1]][start_pos[0] - 1] = '  '
      end
    end
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265f ".dark_piece
      if end_pos[0] - start_pos[0] == 1 && end_pos[1] - start_pos[1] == 1 && @board.pieces[end_pos[1]][end_pos[0]] == '  '
        @board.pieces[start_pos[1]][start_pos[0] + 1] = '  '
      end
      if end_pos[0] - start_pos[0] == -1 && end_pos[1] - start_pos[1] == 1 && @board.pieces[end_pos[1]][end_pos[0]] == '  '
        @board.pieces[start_pos[1]][start_pos[0] - 1] = '  '
      end
    end

    @board.pieces[end_pos[1]][end_pos[0]] = @board.pieces[start_pos[1]][start_pos[0]]
    @board.pieces[start_pos[1]][start_pos[0]] = '  '
    @board.make_board
    if check?(@board.pieces[end_pos[1]][end_pos[0]].possible_moves(end_pos[1], end_pos[0], @board.pieces), @board.pieces, side) 
      puts "<----------Check!---------->"
      @king_in_check = true
    end
    true
  end
end

Game.new
