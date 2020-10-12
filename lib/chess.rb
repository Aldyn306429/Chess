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
    if no_colon(string)
      puts "You're missing a colon"
      return false
    end
    
    string = string.split(':')
    if check_length(string[0]) || check_length(string[1])
      puts 'Incorrect spacing'
      return false
    end
    
    start_pos = translate(string[0].strip)
    end_pos = translate(string[1].strip)
    if check_string(end_pos) || check_string(start_pos)
      puts 'Nonexistent piece for this square'
      return false 
    end
    if @board.pieces[start_pos[1]][start_pos[0]] == '  '
      puts 'No piece selected'
      return false
    end
    if illegal?(@board.pieces[start_pos[1]][start_pos[0]].possible_moves(start_pos[1], start_pos[0], @board.pieces), [end_pos[1], end_pos[0]])
      puts 'Illegal move'
      return false 
    end

    for i in 0..7
      for j in 0..7
        if @board.pieces[i][j] != '  '
          @board.pieces[i][j].possible_moves(i, j, @board.pieces)
        end
      end
    end

    # For Castling
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265a ".light_piece
      check = sightline('Black', @board.pieces)
      if end_pos[0] - start_pos[0] == 2
        [[7, 4], [7, 5], [7, 6]].each do |test|
          if check.include?(test)
            puts "Intercepted by enemy piece"
            return false
          end
        end
        @board.pieces[7][7].history.push('H8 : F8')
        @board.pieces[7][5] = @board.pieces[7][7]
        @board.pieces[7][7] = '  '
      end
      if end_pos[0] - start_pos[0] == -2
        [[7, 4], [7, 3], [7, 2], [7, 1]].each do |test|
          if check.include?(test)
            puts "Intercepted by enemy piece"
            return false
          end
        end
        @board.pieces[7][0].history.push('A8 : D8')
        @board.pieces[7][3] = @board.pieces[7][0]
        @board.pieces[7][0] = '  '
      end
    end
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265a ".dark_piece
      check = sightline('White', @board.pieces)
      if end_pos[0] - start_pos[0] == 2
        [[0, 4], [0, 5], [0, 6]].each do |test|
          if check.include?(test)
            puts "Intercepted by enemy piece"
            return false
          end
        end
        @board.pieces[0][7].history.push('H1 : F1')
        @board.pieces[0][5] = @board.pieces[0][7]
        @board.pieces[0][7] = '  '
      end
      if end_pos[0] - start_pos[0] == -2
        [[0, 4], [0, 3], [0, 2], [0, 1]].each do |test|
          if check.include?(test)
            puts "Intercepted by enemy piece"
            return false
          end
        end
        @board.pieces[0][0].history.push('A1 : D1')
        @board.pieces[0][3] = @board.pieces[0][0]
        @board.pieces[0][0] = '  '
      end
    end

    @board.pieces[start_pos[1]][start_pos[0]].history.push("#{string[0].strip} : #{string[1].strip}")

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
    promotion(@board.pieces)
    @board.make_board
    if check?(@board.pieces[end_pos[1]][end_pos[0]].possible_moves(end_pos[1], end_pos[0], @board.pieces), @board.pieces, side) 
      puts "<----------Check!---------->"
      @king_in_check = true
    end
    true
  end
end

Game.new
