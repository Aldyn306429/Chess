# frozen_string_literal: true

require './lib/pieces/pieces.rb'

describe 'Tests' do
  context 'Pieces' do
    context 'Bishop' do
      context '#possible_moves' do
        context 'White_Bishop' do
          subject { White_Bishop.new }
          it 'Outputs the correct possible moves' do
            test = [[1, 1], [0, 0], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [3, 1], [4, 0], [1, 3], [0, 4]]
            moves = subject.possible_moves(2, 2)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
        context 'Black_Bishop' do
          subject { Black_Bishop.new }
          it 'Outputs the correct possible moves' do
            test = [[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [0, 0], [2, 0], [0, 2]]
            moves = subject.possible_moves(1, 1)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]]
            moves = subject.possible_moves(7, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
      end
    end
    context 'King.rb' do
      context '#possible_moves' do
        context 'White_King' do
          subject { White_King.new}
          it 'Outputs the correct possible moves' do
            test = [[4, 3], [5, 3], [3, 3], [5, 4], [3, 4], [4, 5], [3, 5], [5, 5]]
            moves = subject.possible_moves(4, 4)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[0, 1], [1, 0], [1, 1]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Produces the correct possible moves when castling is available' do
            return false
          end
        end
        context 'Black_King' do
          subject { Black_King.new}
          it 'Outputs the correct possible moves' do
            test = [[4, 4], [5, 4], [6, 4], [6, 5], [4, 5], [4, 6], [5, 6], [6, 6]]
            moves = subject.possible_moves(5, 5)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[6, 7], [7, 6], [6, 6]]
            moves = subject.possible_moves(7, 7)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Produces the correct possible moves when castling is available' do
            return false
          end
        end
      end
    end
    context 'Knight.rb' do
      context '#possible_moves' do
        context 'White_Knight' do
          subject { White_Knight.new}
          it 'Outputs the correct possible moves' do
            test = [[2, 1], [4, 1], [1, 2], [5, 2], [1, 4], [5, 4], [2, 5], [4, 5]]
            moves = subject.possible_moves(3, 3)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[2, 1], [1, 2]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
        context 'Black_Knight' do
          subject { Black_Knight.new}
          it 'Outputs the correct possible moves' do
            test = [[6, 3], [7, 4], [3, 4], [4, 3], [3, 6], [7, 6], [4, 7], [6, 7]]
            moves = subject.possible_moves(5, 5)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[6, 5], [5, 6]]
            moves = subject.possible_moves(7, 7)
            expect(moves.sort).to eql(test.sort)
          end
        end
      end
    end
    context 'Pawn.rb' do
      context '#possible_moves' do
        context 'White_Pawn' do
          subject { White_Pawn.new}
          it 'Outputs the correct possible moves when starting' do
            test = [[0, 5], [0, 4]]
            moves = subject.possible_moves(0, 6)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            # Fill after moving pieces are implemented
            return false
          end
        end
        context 'Black_Pawn' do
          subject { Black_Pawn.new}
          it 'Outputs the correct possible moves when starting' do
            test = [[0, 3], [0, 4]]
            moves = subject.possible_moves(0, 2)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            # Fill after moving pieces are implemented
            return false
          end
        end
      end
    end
    context 'Queen.rb' do
      context '#possible_moves' do
        context 'White_Queen' do
          subject { White_Queen.new}
          it 'Outputs to correct possible moves' do
            test = [[5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], 
            [0, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], 
            [4, 0], [5, 5], [6, 6], [7, 7], [3, 3], [2, 2], [1, 1], 
            [0, 0], [5, 3], [6, 2], [7, 1], [3, 5], [2, 6], [1, 7]]
            moves = subject.possible_moves(4, 4)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], 
            [7, 7], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], 
            [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6 ,0], [7, 0]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
        context 'Black_Queen' do
          subject { Black_Queen.new}
          it 'Outputs to correct possible moves' do
            test = [[5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], 
            [0, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], 
            [4, 0], [5, 5], [6, 6], [7, 7], [3, 3], [2, 2], [1, 1], 
            [0, 0], [5, 3], [6, 2], [7, 1], [3, 5], [2, 6], [1, 7]]
            moves = subject.possible_moves(4, 4)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], 
            [7, 7], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], 
            [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6 ,0], [7, 0]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
      end
    end
    context 'Rook.rb' do
      context '#possible_moves' do
        context 'White_Rook' do
          subject { White_Rook.new}
          it 'Outputs to correct possible moves' do
            test = [[2,  3], [1, 3], [0, 3], [4, 3], [5, 3], [6, 3], [7, 3], [3, 2], [3, 1], [3, 0], [3, 4], [3, 5], [3, 6], [3, 7]]
            moves = subject.possible_moves(3, 3)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
            moves = subject.possible_moves(0, 0)
            expect(moves.sort).to eql(test.sort)
          end
        end
        context 'Black_Rook' do
          subject { Black_Rook.new}
          it 'Outputs to correct possible moves' do
            test = [[2,  3], [1, 3], [0, 3], [4, 3], [5, 3], [6, 3], [7, 3], [3, 2], [3, 1], [3, 0], [3, 4], [3, 5], [3, 6], [3, 7]]
            moves = subject.possible_moves(3, 3)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[7, 6], [7, 5], [7, 4], [7, 3], [7, 2], [7, 1], [7, 0], [6, 7], [5, 7], [4, 7], [3, 7], [2, 7], [1, 7], [0, 7]]
            moves = subject.possible_moves(7, 7)
            expect(moves.sort).to eql(test.sort)
          end
        end
      end
    end
  end
  context 'Board.rb' do
    return false
  end
  context 'Chess.rb' do
    return false
  end
  context 'Game_master.rb' do
    return false
  end
  context 'Player.rb' do
    return false
  end
  context 'Save.rb' do
    return false
  end
end