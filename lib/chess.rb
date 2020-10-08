# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'game_master.rb'
require_relative 'player.rb'
require_relative 'save.rb'
require_relative 'string.rb'

class Game
  include Clean_string
  def initialize
    intro
  end

  def intro
    
  end

  def start_game

  end

  def make_move(string)
    string = string.split(':')
    start_pos = translate(string[0].strip)
    end_pos = translate(string[1].strip)
  end
end

Game.new