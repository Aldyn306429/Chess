# frozen_string_literal: true

class Player_one
  attr_reader :name, :side
  def initialize(name)
    @name = name
    @side = 'white'
  end
end

class Player_two
  attr_reader :name, :side
  def initialize(name)
    @name = name
    @side = 'black'
  end
end
