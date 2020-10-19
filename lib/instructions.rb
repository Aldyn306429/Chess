# frozen_string_literal: true

module Game_Instructions
  def introduction
    puts '<-----------------------Welcome to Chess----------------------->'
    puts "\n<---Creator's note--->"
    puts "This is a game of chess made out of Ruby."
    puts "\n<---Rules--->"
    puts "To learn the rules of chess, please go to https://www.chess.com/learn-how-to-play-chess"
    puts "\n<---Instructions--->"
    puts "In this version of chess, when asked upon how to make a move, please input '<Coordinates of piece> : <Coordinates of location>'"
    puts "For example, if you want to move the white pawn at E2 to the position at E4, you will input 'E2 : E4'"
    puts "\n<---IMPORTANT--->"
    puts "If you want to offer a draw, input 'draw' when asked to make a move"
    puts "If you want to save the game you're playing on right now, input 'save' when asked to make a move"
    puts "\nThis is all the instructions for this game of chess. Anyways, I hope you have a fun game!"
  end

  def pick_mode
    puts "\nPlease pick a mode"
    puts "\n1. New Game"
    puts "2. Load Game"
    puts "3. Leave Chess"
    puts "\nInput mode: "
  end
end