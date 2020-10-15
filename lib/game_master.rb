# frozen_string_literal: true

require_relative 'pieces/pieces.rb'

module Game_Rules
  def illegal?(moves, lust)
    moves.each do |pos| 
      return false if pos == lust
    end
    true
  end

  # For check and checkmate
  def check?(board, side)
    test = "\u265a ".light_piece if side == 'Black'
    test = "\u265a ".dark_piece if side == 'White'
    return [] if side.nil?
    
    attack_pieces = []
    king_pos = find_piece(test, board)

    check = White_Bishop.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'Black'
    check = Black_Bishop.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'White'

    check.each do |pos|
      if board[pos[0]][pos[1]] != '  '
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265b ".light_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265b ".dark_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265d ".light_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265d ".dark_piece && board[pos[0]][pos[1]].identity == side.downcase
      end
    end

    check = White_Rook.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'Black'
    check = Black_Rook.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'White'

    check.each do |pos|
      if board[pos[0]][pos[1]] != '  '
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265b ".light_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265b ".dark_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265c ".light_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265c ".dark_piece && board[pos[0]][pos[1]].identity == side.downcase
      end
    end

    check = White_Knight.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'Black'
    check = Black_Knight.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'White'

    check.each do |pos|
      if board[pos[0]][pos[1]] != '  '
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265e ".light_piece && board[pos[0]][pos[1]].identity == side.downcase
        attack_pieces.push([pos[0], pos[1]]) if board[pos[0]][pos[1]].piece == "\u265e ".dark_piece && board[pos[0]][pos[1]].identity == side.downcase
      end
    end

    if side == 'Black'
      if (king_pos[0] - 1).between?(0, 7) && (king_pos[1] + 1).between?(0, 7) && board[king_pos[0] - 1][king_pos[1] + 1] != '  '
        attack_pieces.push([king_pos[0] - 1, king_pos[1] + 1]) if board[king_pos[0] - 1][king_pos[1] + 1].piece == "\u265f ".dark_piece
      end
      if (king_pos[0] - 1).between?(0, 7) && (king_pos[1] - 1).between?(0, 7) && board[king_pos[0] - 1][king_pos[1] - 1] != '  '
        attack_pieces.push([king_pos[0] - 1, king_pos[1] - 1]) if board[king_pos[0] - 1][king_pos[1] - 1].piece == "\u265f ".dark_piece
      end
    elsif side == 'White'
      if (king_pos[0] + 1).between?(0, 7) && (king_pos[1] - 1).between?(0, 7) && board[king_pos[0] + 1][king_pos[1] - 1] != '  '
        attack_pieces.push([king_pos[0] + 1, king_pos[1] - 1]) if board[king_pos[0] + 1][king_pos[1] - 1].piece == "\u265f ".light_piece
      end
      if (king_pos[0] + 1).between?(0, 7) && (king_pos[1] + 1).between?(0, 7) && board[king_pos[0] + 1][king_pos[1] + 1] != '  '
        attack_pieces.push([king_pos[0] + 1, king_pos[1] + 1]) if board[king_pos[0] + 1][king_pos[1] + 1].piece == "\u265f ".light_piece
      end
    end

    attack_pieces
  end

  def checkmate?(side, attack_piece, board)
    return false if attack_piece.empty?
    test = "\u265a ".light_piece if side == 'Black'
    test = "\u265a ".dark_piece if side == 'White'
    
    king_pos = find_piece(test, board)
    result = 0

    test1 = sightline(side, board)
    result += 1 if mate_check_1(test1, king_pos, side, board)

    temp2 = 'Black' if side == 'White'
    temp2 = 'White' if side == 'Black'
    test2 = sightline(temp2, board)
    result += 1 if mate_check_2(attack_piece, test2, king_pos, board, side)

    test3 = moveable_pieces(test1, temp2, board)
    result += 1 if mate_check_3(test3, board, king_pos, attack_piece)

    result == 3 ? true : false
  end

  def mate_check_1(array, king_pos, side, board)
    testing_piece = White_King.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'Black'
    testing_piece = Black_King.new.possible_moves(king_pos[0], king_pos[1], board) if side == 'White'

    testing_piece.each do |pos|
      next if board[pos[0]][pos[1]] != '  '
      return false if array.include?(pos) == false
    end
    true
  end

  def mate_check_2(attack_piece, sightline, king_pos, board, side)
    return true if attack_piece.size > 1

    test_array = []
    sightline.each do |pos|
      test_array.push(pos) if pos == attack_piece[0]
    end
    
    return false if test_array.size > 1
    return true if test_array.empty?

    if (attack_piece[0][0] - king_pos[0]).between?(-1, 1) && (attack_piece[0][1] - king_pos[1]).between?(-1, 1)
      escape_check(king_pos, attack_piece[0], board, side) ? true : false
    end
  end

  def mate_check_3(moveable, board, king_pos, atkPiece)
    return true if moveable.empty? || attack_piece.size > 1
      
    a = [attack_piece[1], king_pos[1]].max
    b = [attack_piece[1], king_pos[1]].min
    c = [attack_piece[0], king_pos[0]].max
    d = [attack_piece[0], king_pos[0]].min

    temp_array = []

    b.upto(a) do |i|
      d.upto(c) do |j|
        temp_array.push([i, j])
      end
    end

    test_array = []
    temp_array.each do |pos|
      test_array.push(pos) if board[atkPiece[0]][atkPiece[1]].moves.include?(pos)
    end

    moveable_array = []
    moveable.each do |pos|
      moveable_array.push(board[pos[0]][pos[1]].possible_moves(pos[0], pos[1], board))
    end

    moveable_array = moveable_array.flatten(1)
    test_array.each do |pos|
      return false if moveable_array.include?(pos)
    end

    true
  end

  def escape_check(start_pos, end_pos, board, side)
    memoryA = board[start_pos[0]][start_pos[1]]
    memoryB = board[end_pos[0]][end_pos[1]]

    board[end_pos[0]][end_pos[1]] = board[start_pos[0]][start_pos[1]]
    board[start_pos[0]][start_pos[1]] = '  '

    if check?(board, side).empty? == false
      board[start_pos[0]][start_pos[1]] = memoryA
      board[end_pos[0]][end_pos[1]] = memoryB
      return true
    else
      return false
    end
  end

  def moveable_pieces(sightline, test, board)
    moveable = []
    for i in 0..7 do
      for j in 0..7 do
        if board[i][j] != '  ' && sightline.include?([i, j]) == false
          moveable.push(board[i][j]) if board[i][j].identity == test
        end
      end
    end

    moveable
  end

  def find_piece(piece, board)
    for i in 0..7 do
      for j in 0..7 do
        if board[i][j] != '  '
          return [i, j] if board[i][j].piece == piece 
        end
      end
    end
  end

  #########################

  def sightline(side, board)
    answer = []
    test = 'black' if side == 'Black'
    test = 'white' if side == 'White'

    for i in 0..7 do
      for j in 0..7 do
        if board[i][j] != '  '
          answer.push(board[i][j].possible_moves(i, j, board)) if board[i][j].identity == test
        end
      end
    end

    answer.flatten(1)
  end

  # For pawn promotion
  def promotion(board, user)
    0.upto(7) do |i|
      if board[0][i] != '  '
        if board[0][i].piece == "\u265f ".light_piece
          user = ask_for_promotion if user.nil?
          board[0][i] = White_Queen.new if user == 1
          board[0][i] = White_Rook.new if user == 2
          board[0][i] = White_Bishop.new if user == 3
          board[0][i] = White_Knight.new if user == 4
          board[0][i].history.push("#{(i + 65).chr.upcase}8^")
          break
        end
      end
      if board[7][i] != '  '
        if board[7][i].piece == "\u265f ".dark_piece
          user = ask_for_promotion if user.nil?
          board[7][i] = Black_Queen.new if user == 1
          board[7][i] = Black_Rook.new if user == 2
          board[7][i] = Black_Bishop.new if user == 3
          board[7][i] = Black_Knight.new if user == 4
          board[7][i].history.push("#{(i + 65).chr.upcase}1^")
          break
        end
      end
    end
  end

  private
  
  # For the user input regarding the promotion for the pawn
  def ask_for_promotion
    puts 'What do you want to promote the pawn to?'
    puts "\n1. Queen\n2. Rook\n3. Bishop\n4. Knight" 
    puts "\nInput a number: "
    answer = gets.chomp.to_i
    until answer.between?(1, 4)
      puts "\nPlease input a number from one to four: "
      answer = gets.chomp.to_i
    end
    answer
  end
end