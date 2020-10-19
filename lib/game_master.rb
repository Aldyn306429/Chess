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
    test3 = moveable_pieces(board, side)
    
    result += 1 if mate_check_2(attack_piece, test3, king_pos, board, side)
    result += 1 if mate_check_3(test3, board, king_pos, attack_piece, side)

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

  def mate_check_2(attack_piece, pieces, king_pos, board, side)
    return true if attack_piece.size > 1
    test_array = []
    pieces.each do |pos|
      p_moves = board[pos[0]][pos[1]].possible_moves(pos[0], pos[1], board)
      test_array.push(pos) if p_moves.include?(attack_piece[0]) && escape_check(pos, attack_piece[0], board, side) == false
    end

    return true if test_array.empty?
    return false if test_array.size > 1

    if (attack_piece[0][0] - king_pos[0]).between?(-1, 1) && (attack_piece[0][1] - king_pos[1]).between?(-1, 1) && test_array.size == 1
      if escape_check(king_pos, attack_piece[0], board, side)
        return true
      else
        return false
      end
    end

    true
  end

  def mate_check_3(moveable, board, king_pos, atkPiece, side)
    return true if moveable.empty? || atkPiece.size > 1
    
    a = [atkPiece[0][1], king_pos[1]].max
    b = [atkPiece[0][1], king_pos[1]].min
    c = [atkPiece[0][0], king_pos[0]].max
    d = [atkPiece[0][0], king_pos[0]].min

    temp_array = []

    b.upto(a) do |i|
      d.upto(c) do |j|
        temp_array.push([i, j])
      end
    end

    test_array = []
    temp_array.each do |pos|
      test_array.push(pos) if board[atkPiece[0][0]][atkPiece[0][1]].moves.include?(pos)
    end

    moveable_array = []
    moveable.each do |pos|
      p_moves = board[pos[0]][pos[1]].possible_moves(pos[0], pos[1], board)
      next if p_moves.empty?
      moveable_array.push(p_moves) if escape_check(pos, p_moves[0], board, side) == false
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
      board[start_pos[0]][start_pos[1]] = memoryA
      board[end_pos[0]][end_pos[1]] = memoryB
      return false
    end
  end

  def moveable_pieces(board, side)
    test = 'white' if side == 'Black'
    test = 'black' if side == 'White'
    moveable = []

    for i in 0..7 do
      for j in 0..7 do
        if board[i][j] != '  '
          moveable.push([i, j]) if board[i][j].identity == test
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

  def stalemate(board, side)
    pieces = moveable_pieces(board, side)
    pieces.each do |pos|
      moves = board[pos[0]][pos[1]].possible_moves(pos[0], pos[1], board)
      moves.each do |test|
        return false if escape_check(pos, test, board, side) == false
      end
    end

    true
  end

  def king_no_king(king_pos, end_pos, board, side)
    test = "\u265a ".dark_piece if side == 'Black'
    test = "\u265a ".light_piece if side == 'White'

    if side == 'Black'
      test_moves = board[king_pos[0]][king_pos[1]].possible_moves(end_pos[0], end_pos[1], board)
      test_moves.each do |pos|
        if board[pos[0]][pos[1]] != '  '
          return true if board[pos[0]][pos[1]].piece == "\u265a ".light_piece
        end
      end
    end
    if side == 'White'
      test_moves = board[king_pos[0]][king_pos[1]].possible_moves(end_pos[0], end_pos[1], board)
      test_moves.each do |pos|
        if board[pos[0]][pos[1]] != '  '
          return true if board[pos[0]][pos[1]].piece == "\u265a ".dark_piece
        end
      end
    end
    false
  end

  private
  
  # For the user input regarding the promotion for the pawn
  def ask_for_promotion
    puts "\n<--------Promotion-------->"
    puts "What do you want to promote the pawn to?"
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