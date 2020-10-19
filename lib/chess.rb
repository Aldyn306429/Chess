# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'game_master.rb'
require_relative 'player.rb'
require_relative 'save.rb'
require_relative 'string.rb'
require_relative 'instructions.rb'

class Game
  include Clean_String
  include Game_Rules
  include Game_Instructions

  attr_reader :board, :king_in_check, :victory
  def initialize
    pieces = Pieces.new
    @victory = false
    @game_over = false
    @board = Board.new(pieces.pieces_pos)
    @king_in_check = false
    @round_number = 0
    intro
  end

  def intro
    introduction
    pick_mode
    response = gets.chomp.to_i
    until response.between?(1, 3)
      puts "\nInvalid Input!"
      puts "Input Mode: "
      response = gets.chomp.to_i
    end
    if response == 1
      get_names
      start_game
    end
    load_game if response == 2
    if response == 3
      puts "\nI hope you have a good rest of your day!\n\nLeaving game"
    end
  end

  def get_names
    puts "\nWhite player's name: "
    name = gets.chomp
    @player1 = Player_one.new(name)
    puts "\nBlack player's name: "
    name = gets.chomp
    @player2 = Player_two.new(name)
  end

  def start_game
    @round_number
    until @game_over
      (@round_number % 2).zero? ? player = @player1 : player = @player2
      puts "\n<------Round #{@round_number + 1}------>"
      puts @board.display_board
      puts "#{player.name}'s turn ( #{player.side} )"
      response = gets.chomp
      until test = make_move(response, player.side)
        puts "#{player.name}'s turn ( #{player.side} )"
        response = gets.chomp
        break if test == 'draw'
        if test == 'save'
          save_game({player_one: @player1, player_two: @player2, board: @board, king_check: @king_in_check, rNumber: @round_number})
          exit
        end
      end
      @game_over = true if test == 'draw'
      if test == 'save'
        save_game({player_one: @player1, player_two: @player2, board: @board, king_check: @king_in_check, rNumber: @round_number})
        exit
      end
      if @victory
        puts "\nGame over! #{player.name} won, congrats!"
        break
      end
      if @game_over
        puts "\nGame ended in a draw"
        break
      end
      @round_number += 1
    end
  end

  def make_move(string, side = nil, rspec_test = nil)
    if string.downcase.include?('draw')
      puts "\nConfirm draw? ( Yes / No )"
      response = gets.chomp.downcase
      if response.include?('yes')
        @game_over = true
        return 'draw'
      end
    end

    return 'save' if string.downcase.include?('save')

    if no_colon(string)
      puts "\nYou're missing a colon"
      return false
    end
    
    string = string.split(':')
    if check_length(string[0]) || check_length(string[1])
      puts "\nIncorrect spacing"
      return false
    end
    
    start_pos = translate(string[0].strip)
    end_pos = translate(string[1].strip)

    if check_string(end_pos) || check_string(start_pos)
      puts "\nNonexistent piece for this square"
      return false 
    end

    if @board.pieces[start_pos[1]][start_pos[0]] == '  '
      puts "\nNo piece selected"
      return false
    end

    if illegal?(@board.pieces[start_pos[1]][start_pos[0]].possible_moves(start_pos[1], start_pos[0], @board.pieces), [end_pos[1], end_pos[0]])
      puts "\nIllegal move"
      return false 
    end

    # Checks if the piece being used is part of the players pieces
    unless side.nil?
      if side.downcase != @board.pieces[start_pos[1]][start_pos[0]].identity
        puts "\n<-----It's #{side}'s turn----->"
        return false
      end
    end

    # Checks if king is going into a positioned that would get the piece checked
    temp_side = 'Black' if side == 'White'
    temp_side = 'White' if side == 'Black'
    if escape_check([start_pos[1], start_pos[0]], [end_pos[1], end_pos[0]], @board.pieces, temp_side)
      puts "\nYou\'re king will be in check"
      return false
    end

    for i in 0..7
      for j in 0..7
        if @board.pieces[i][j] != '  '
          @board.pieces[i][j].possible_moves(i, j, @board.pieces)
        end
      end
    end

    # Checks if the king is going be next to another king
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265a ".light_piece || @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265a ".dark_piece
      if king_no_king([start_pos[1], start_pos[0]], [end_pos[1], end_pos[0]], @board.pieces, side)
        puts "\nKing can't be next to another king"
        return false
      end
    end

    # For Castling
    if @board.pieces[start_pos[1]][start_pos[0]].piece == "\u265a ".light_piece
      check = sightline('Black', @board.pieces)
      if end_pos[0] - start_pos[0] == 2
        [[7, 4], [7, 5], [7, 6]].each do |test|
          if check.include?(test)
            puts "\nIntercepted by enemy piece"
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
            puts "\nIntercepted by enemy piece"
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
            puts "\nIntercepted by enemy piece"
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
            puts "\nIntercepted by enemy piece"
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

    until @king_in_check == false
      temp = 'Black' if side == 'White'
      temp = 'White' if side == 'Black'
      if escape_check([start_pos[1], start_pos[0]], [end_pos[1], end_pos[0]], @board.pieces, temp)
        puts "\nKing still in check"
        return false
      end
      
      @king_in_check = false
    end
    
    @board.pieces[end_pos[1]][end_pos[0]] = @board.pieces[start_pos[1]][start_pos[0]]
    @board.pieces[start_pos[1]][start_pos[0]] = '  '
    
    promotion(@board.pieces, rspec_test)
    @board.make_board
    attackers = check?(@board.pieces, side)

    unless attackers.empty?
      @king_in_check = true
      if checkmate?(side, attackers, @board.pieces)
        puts "\n<--------Checkmate!-------->"
        puts @board.display_board
        @victory = true
      else
        puts "\n<----------Check!---------->"
      end
    end

    if stalemate(@board.pieces, side) && @victory == false
      puts "\n<---------Stalemate!--------->"
      puts @board.display_board
      @game_over = true
    end

    true
  end
end

Game.new
