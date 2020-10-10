# frozen_string_literal: true

module Game_Rules
  def illegal?(moves, lust)
    moves.each do |pos| 
      return false if pos == lust
    end
    true
  end
end