# frozen_string_literal: true

require './lib/pieces/pieces.rb'
require './lib/board.rb'
require './lib/game_master.rb'
require './lib/chess.rb'
require './lib/string.rb'

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
          subject { White_Pawn.new }
          it 'Outputs the correct possible moves when starting' do
            test = [[4, 0], [5, 0]]
            moves = subject.possible_moves(6, 0)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            test = Game.new
            test.make_move('C7 : C5')
            moves = test.board.pieces[3][2].possible_moves(3, 2)
            expect(moves.sort).to eql([[4, 2]])
          end
        end
        context 'Black_Pawn' do
          subject { Black_Pawn.new }
          it 'Outputs the correct possible moves when starting' do
            test = [[3, 0], [2, 0]]
            moves = subject.possible_moves(1, 0)
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            test = Game.new
            test.make_move('D7 : D5')
            moves = test.board.pieces[3][3].possible_moves(3, 3)
            expect(moves.sort).to eql([[4, 3]])
          end
        end
      end
    end
    context 'Queen.rb' do
      context '#possible_moves' do
        context 'White_Queen' do
          subject { White_Queen.new }
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
          subject { Black_Queen.new }
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
          subject { White_Rook.new }
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
          subject { Black_Rook.new }
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
    context 'displaying the board' do
      subject { Board.new(Pieces.new.pieces_pos) }
      it 'Correct starting board' do
        test = [[Black_Rook.new, Black_Knight.new, Black_Bishop.new, Black_Queen.new, Black_King.new, Black_Bishop.new, Black_Knight.new, Black_Rook.new], 
        [Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new, Black_Pawn.new], 
        ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
        ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
        ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
        ['  ', '  ', '  ', '  ', '  ', '  ', '  ', '  '], 
        [White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new, White_Pawn.new], 
        [White_Rook.new, White_Knight.new, White_Bishop.new, White_Queen.new, White_King.new, White_Bishop.new, White_Knight.new, White_Rook.new]]
        expect(subject.pieces == test)
      end
    end
  end
  context 'Game_master.rb' do
    context '#illegal?' do
      subject { Game.new }
      it 'Legal moves for pawns(1)' do
        expect(subject.make_move('D2 : D5')).to eql(false)
      end
      it 'Legal moves for pawns(2)' do
        expect(subject.make_move('D2 : D4')).to_not eql(false)
      end
      it 'Legal moves for knights(1)' do
        expect(subject.make_move('B1 : F8')).to eql(false)      
      end
      it 'Legal moves for knights(2)' do
        expect(subject.make_move('B1 : C3')).to_not eql(false)
      end
      it 'Legal moves for kings(1)' do
        expect(subject.make_move('E1 : C1')).to eql(false) 
      end
      it 'Legal moves for kings(2)' do
        expect(subject.make_move('E1 : D2')).to_not eql(false)
      end
      it 'Legal moves for queens(1)' do
        expect(subject.make_move('D1 : E8')).to eql(false) 
      end
      it 'Legal moves for queens(2)' do
        expect(subject.make_move('D1 : D8')).to_not eql(false)
      end
      it 'Legal moves for rooks(1)' do
        expect(subject.make_move('A1 : B8')).to eql(false) 
      end
      it 'Legal moves for rooks(2)' do
        expect(subject.make_move('A1 : A8')).to_not eql(false)
      end
      it 'Legal moves for bishops(1)' do
        expect(subject.make_move('C1 : B1')).to eql(false) 
      end
      it 'Legal moves for bishops(2)' do
        expect(subject.make_move('C1 : B2')).to_not eql(false)
      end
    end
  end
  context 'Chess.rb' do
    return false
  end
  context 'Player.rb' do
    return false
  end
  context 'Save.rb' do
    return false
  end
end