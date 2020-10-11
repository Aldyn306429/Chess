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
    test = "\u265a ".light_piece if side == 'black'
    test = "\u265a ".dark_piece if side == 'white'
    moves.each do |piece|
      if board[piece[1]][piece[0]] != '  '
        return true if board[piece[1]][piece[0]].piece == test
      end
    end
    return false
  end
end