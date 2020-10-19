# frozen_string_literal: true

require './lib/pieces/pieces.rb'
require './lib/board.rb'
require './lib/game_master.rb'
require './lib/chess.rb'
require './lib/string.rb'
require './lib/instructions.rb'

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
          subject { White_King.new }
          it 'Outputs the correct possible moves' do
            test = [[4, 3], [5, 3], [3, 3], [5, 4], [3, 4], [4, 5], [3, 5], [5, 5]]
            moves = subject.possible_moves(4, 4, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[0, 1], [1, 0], [1, 1]]
            moves = subject.possible_moves(0, 0, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Produces the correct possible moves when castling to kingside is available' do
            game = Game.new
            game.make_move('E2 : E4')
            game.make_move('G1 : F3')
            game.make_move('F1 : B5')
            expect(game.board.pieces[7][4].possible_moves(7, 4, game.board.pieces).include?([7, 6]))
          end
          it 'Produces the correct possible moves when castling to queenside is available' do
            game = Game.new
            game.make_move('D2 : D4')
            game.make_move('C1 : E3')
            game.make_move('D1 : D2')
            game.make_move('B1 : C3')
            expect(game.board.pieces[7][4].possible_moves(7, 4, game.board.pieces).include?([7, 2]))
          end
        end
        context 'Black_King' do
          subject { Black_King.new }
          it 'Outputs the correct possible moves' do
            test = [[4, 4], [5, 4], [6, 4], [6, 5], [4, 5], [4, 6], [5, 6], [6, 6]]
            moves = subject.possible_moves(5, 5, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside of the board' do
            test = [[6, 7], [7, 6], [6, 6]]
            moves = subject.possible_moves(7, 7, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Produces the correct possible moves when castling to kingside is available' do
            game = Game.new
            game.make_move('E7 : E5')
            game.make_move('F8 : C5')
            game.make_move('G8 : F6')
            expect(game.board.pieces[0][4].possible_moves(0, 4, game.board.pieces).include?([0, 6]))
          end
          it 'Produces the correct possible moves when castling to queenside is available' do
            game = Game.new
            game.make_move('D7 : D6')
            game.make_move('C8 : E6')
            game.make_move('B8 : C6')
            game.make_move('D8 : D7')
            expect(game.board.pieces[0][4].possible_moves(0, 4, game.board.pieces).include?([0, 2]))
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
            moves = subject.possible_moves(3, 3, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[2, 1], [1, 2]]
            moves = subject.possible_moves(0, 0, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
        end
        context 'Black_Knight' do
          subject { Black_Knight.new}
          it 'Outputs the correct possible moves' do
            test = [[6, 3], [7, 4], [3, 4], [4, 3], [3, 6], [7, 6], [4, 7], [6, 7]]
            moves = subject.possible_moves(5, 5, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Does not output moves outside the board' do
            test = [[6, 5], [5, 6]]
            moves = subject.possible_moves(7, 7, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
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
            moves = subject.possible_moves(6, 0, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            test = Game.new
            test.make_move('C7 : C5')
            moves = test.board.pieces[3][2].possible_moves(3, 2, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql([[4, 2]])
          end
        end
        context 'Black_Pawn' do
          subject { Black_Pawn.new }
          it 'Outputs the correct possible moves when starting' do
            test = [[3, 0], [2, 0]]
            moves = subject.possible_moves(1, 0, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
            expect(moves.sort).to eql(test.sort)
          end
          it 'Outputs the correct possible moves after moved already' do
            test = Game.new
            test.make_move('D7 : D5')
            moves = test.board.pieces[3][3].possible_moves(3, 3, Array.new(8, ['  ','  ','  ','  ','  ','  ','  ','  ']))
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
        subject.make_move('D2 : D4')
        expect(subject.make_move('E1 : D2')).to_not eql(false)
      end
      it 'Legal moves for queens(1)' do
        expect(subject.make_move('D1 : E8')).to eql(false) 
      end
      it 'Legal moves for queens(2)' do
        subject.make_move('D2 : D4')
        subject.make_move('E7 : E5')
        subject.make_move('D4 : E5')
        subject.make_move('D7 : D5')
        subject.make_move('C2 : C4')
        subject.make_move('D5 : C4')
        expect(subject.make_move('D1 : D8')).to_not eql(false)
      end
      it 'Legal moves for rooks(1)' do
        expect(subject.make_move('A1 : B8')).to eql(false) 
      end
      it 'Legal moves for rooks(2)' do
        subject.make_move('A2 : A4')
        subject.make_move('B2 : B4')
        subject.make_move('A7 : A5')
        subject.make_move('B7 : B5')
        subject.make_move('A4 : B5')
        subject.make_move('A5 : B4')
        expect(subject.make_move('A1 : A8')).to_not eql(false)
      end
      it 'Legal moves for bishops(1)' do
        expect(subject.make_move('C1 : B1')).to eql(false) 
      end
      it 'Legal moves for bishops(2)' do
        subject.make_move('B2 : B3')
        expect(subject.make_move('C1 : B2')).to_not eql(false)
      end
    end
    context '#check?' do
      subject { Game.new }
      it 'Returns true when king is checked(1)' do
        subject.make_move('C2 : C3', 'White')
        subject.make_move('D1 : A4', 'White')
        subject.make_move('A4 : D7', 'White')
        expect(subject.king_in_check).to eql(true)
      end
      it 'Returns true when king is checked(2)' do
        subject.make_move('C2 : C3', 'White')
        subject.make_move('D7 : D6', 'Black')
        subject.make_move('D1 : A4', 'White')
        subject.make_move('C8 : D7', 'Black')
        subject.make_move('A4 : D7', 'White')
        expect(subject.king_in_check).to eql(true)
      end
      it 'Returns true when pawn checks the king(1)' do
        subject.make_move('E2 : E4', 'White')
        subject.make_move('E4 : E5', 'White')
        subject.make_move('E5 : E6', 'White')
        subject.make_move('E6 : D7', 'White')
        expect(subject.king_in_check).to eql(true)
      end
      it 'Returns true when pawn checks the king(2)' do
        subject.make_move('E7 : E5', 'Black')
        subject.make_move('E5 : E4', 'Black')
        subject.make_move('E4 : E3', 'Black')
        subject.make_move('E3 : D2', 'Black')
        expect(subject.king_in_check).to eql(true)
      end
      it 'Returns false when king is not checked' do
        subject.make_move('C2 : C3', 'White')
        subject.make_move('D7 : D6', 'Black')
        subject.make_move('C8 : D7', 'Black')
        subject.make_move('D1 : A4', 'White')
        expect(subject.king_in_check).to eql(false)
      end
    end
    context 'En Passant' do
      subject { Game.new }
      it 'En Passant for dark piece to the left' do
        subject.make_move('D7 : D5')
        subject.make_move('D5 : D4')
        subject.make_move('C2 : D4')
        subject.make_move('D4 : C3')
        expect(subject.board.pieces[4][2] == '  ').to eql(true)
      end
      it 'En Passant for dark piece to the right' do
        subject.make_move('B7 : B5')
        subject.make_move('B5 : B4')
        subject.make_move('C2 : C4')
        subject.make_move('B4 : C3')
        expect(subject.board.pieces[4][2] == '  ').to eql(true)
      end
      it 'En Passant for light piece to the left' do
        subject.make_move('G2 : G4')
        subject.make_move('G4 : G5')
        subject.make_move('F7 : F5')
        subject.make_move('G5 : F6')
        expect(subject.board.pieces[3][5] == '  ').to eql(true)
      end
      it 'En Passant for light piece to the right' do
        subject.make_move('C2 : C4')
        subject.make_move('C4 : C5')
        subject.make_move('D7 : D5')
        subject.make_move('C5 : D6')
        expect(subject.board.pieces[3][3] == '  ').to eql(true)
      end
      it 'En Passant disappears after one move' do
        subject.make_move('C2 : C4')
        subject.make_move('C4 : C5')
        subject.make_move('D7 : D5')
        subject.make_move('A2 : A3')
        expect(subject.board.pieces[3][2].possible_moves(3, 2, subject.board.pieces).include?([2, 3])).to eql(false)
      end
      it 'En Passant disappears after one move but new En Passant appears' do
        subject.make_move('C2 : C4')
        subject.make_move('C4 : C5')
        subject.make_move('D7 : D5')
        subject.make_move('B7 : B5')
        subject.make_move('C5 : B6')
        expect(subject.board.pieces[4][1] == '  ').to eql(true)
      end
    end
    context 'Pawn Promotion' do
      subject { Game.new }
      it 'Promotes correctly on the white side' do
        subject.make_move('B7 : B5')
        subject.make_move('B5 : B4')
        subject.make_move('B4 : B3')
        subject.make_move('B3 : C2')
        subject.make_move('C2 : B1', 'Black', 4)
        expect(subject.board.pieces[7][1].piece).to eql("\u265e ".dark_piece)
      end
      it 'Promotes correctly on the black side' do
        subject.make_move('B2 : B4')
        subject.make_move('B4 : B5')
        subject.make_move('B5 : B6')
        subject.make_move('B6 : C7')
        subject.make_move('C7 : B8', 'White', 3)
        expect(subject.board.pieces[0][1].piece).to eql("\u265d ".light_piece)
      end
    end
    context 'Checkmate' do
      subject { Game.new }
      it 'Returns false when checkmate is false (Simple)' do
        subject.make_move('E2 : E4', 'White')
        subject.make_move('E7 : E5', 'Black')
        subject.make_move('D1 : F3', 'White')
        subject.make_move('D7 : D6', 'Black')
        subject.make_move('F3 : F7', 'White')
        if subject.king_in_check
          expect(subject.victory).to eql(false)
        else
          return false
        end
      end
      it 'Returns false when checkmate is false (Complicated)' do
        subject.make_move('E2 : E4', 'White')
        subject.make_move('D7 : D5', 'Black')
        subject.make_move('F1 : B5', 'White')
        if subject.king_in_check
          expect(subject.victory).to eql(false)
        else
          return false
        end
      end
      it 'Returns true when checkmate is true (Simple)' do
        subject.make_move('E2 : E4', 'White')
        subject.make_move('E7 : E5', 'Black')
        subject.make_move('D1 : F3', 'White')
        subject.make_move('D7 : D6', 'Black')
        subject.make_move('F1 : C4', 'White')
        subject.make_move('A7 : A5', 'Black')
        subject.make_move('F3 : F7', 'White')
        expect(subject.victory).to eql(true)
      end
      it 'Returns true when checkmate is true (Complicated)' do
        subject.make_move('D2 : D4', 'White')
        subject.make_move('C7 : C6', 'Black')
        subject.make_move('E2 : E4', 'White')
        subject.make_move('D7 : D5', 'Black')
        subject.make_move('B1 : C3', 'White')
        subject.make_move('D5 : E4', 'Black')
        subject.make_move('C3 : E4', 'White')
        subject.make_move('B8 : D7', 'Black')
        subject.make_move('D1 : E2', 'White')
        subject.make_move('G8 : F6', 'Black')
        subject.make_move('E4 : D6', 'White')
        expect(subject.victory).to eql(true)
      end
    end
  end
  context 'Chess.rb' do
    context 'Castling' do
      subject { Game.new }
      it 'Enemy sight in path will block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('C1 : D2')
        subject.make_move('E7 : E6')
        subject.make_move('F8 : B4')
        subject.make_move('G8 : F6')
        subject.make_move('D2 : B4')
        subject.make_move('E8 : G8')
        expect(subject.board.pieces[0][4] == '  ').to eql(false)
      end
      it 'Enemy sight not in path will not block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('C1 : D2')
        subject.make_move('E7 : E6')
        subject.make_move('F8 : E7')
        subject.make_move('G8 : F6')
        subject.make_move('D2 : B4')
        subject.make_move('E8 : G8')
        expect(subject.board.pieces[0][4] == '  ').to eql(true)
      end
      it 'Enemy sight in path will block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('E7 : E6')
        subject.make_move('C1 : G5')
        subject.make_move('D7 : D6')
        subject.make_move('C8 : H3')
        subject.make_move('B8 : A6')
        subject.make_move('D8 : D7')
        subject.make_move('E8 : C8')
        expect(subject.board.pieces[0][4] == '  ').to eql(false)
      end
      it 'Enemy sight not in path will not block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('E7 : E6')
        subject.make_move('C1 : G5')
        subject.make_move('D7 : D6')
        subject.make_move('C8 : D7')
        subject.make_move('B8 : A6')
        subject.make_move('D8 : E7')
        subject.make_move('E8 : C8')
        expect(subject.board.pieces[0][4] == '  ').to eql(true)
      end
      it 'Enemy sight in path will block castling' do
        subject.make_move('E2 : E3')
        subject.make_move('B7 : B6')
        subject.make_move('F1 : A6')
        subject.make_move('C8 : A6')
        subject.make_move('G1 : F3')
        subject.make_move('E1 : G1')
        expect(subject.board.pieces[7][4] == '  ').to eql(false)
      end
      it 'Enemy sight in path will block castling' do
        subject.make_move('E2 : E3')
        subject.make_move('B7 : B6')
        subject.make_move('F1 : E2')
        subject.make_move('C8 : A6')
        subject.make_move('G1 : F3')
        subject.make_move('E1 : G1')
        expect(subject.board.pieces[7][4] == '  ').to eql(true)
      end
      it 'Enemy sight not in path will not block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('G7 : G6')
        subject.make_move('C2 : C3')
        subject.make_move('D1 : C2')
        subject.make_move('C1 : H6')
        subject.make_move('F8 : H6')
        subject.make_move('B1 : A3')
        subject.make_move('E1 : C1')
        expect(subject.board.pieces[7][4] == '  ').to eql(false)
      end
      it 'Enemy sight not in path will not block castling' do
        subject.make_move('D2 : D3')
        subject.make_move('G7 : G6')
        subject.make_move('C2 : C3')
        subject.make_move('D1 : C2')
        subject.make_move('C1 : D2')
        subject.make_move('F8 : H6')
        subject.make_move('B1 : A3')
        subject.make_move('E1 : C1')
        expect(subject.board.pieces[7][4] == '  ').to eql(true)
      end
    end
  end
  context 'Player.rb' do
    return false
  end
  context 'Save.rb' do
    return false
  end
end