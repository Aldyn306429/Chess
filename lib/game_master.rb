# frozen_string_literal: true

require_relative 'pieces/pieces.rb'

module Game_Rules
  def illegal?(moves, lust)
    moves.each do |pos| 
      return false if pos == lust
    end
    true
  end

  def check?(moves, board, side)
    test = "\u265a ".light_piece if side == 'Black'
    test = "\u265a ".dark_piece if side == 'White'
    moves.each do |piece|
      if board[piece[1]][piece[0]] != '  '
        return true if board[piece[1]][piece[0]].piece == test
      end
    end
    return false
  end

  def sightline(side, board)
    answer = []
    test = 'black' if side == 'Black'
    test = 'white' if side == 'White'

    for i in 0..7 do
      for j in 0..7 do
        if board[i][j] != '  '
          answer.push(board[i][j].moves) if board[i][j].identity == test
        end
      end
    end

    answer.flatten(1)
  end

  # For pawn promotion
  def promotion(board)
    0.upto(7) do |i|
      if board[0][i] != '  '
        if board[0][i].piece == "\u265f ".light_piece
          user = ask_for_promotion
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
          user = ask_for_promotion
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