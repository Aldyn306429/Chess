# frozen_string_literal: true

class Player_one
  attr_reader :name, :side
  def initialize(name)
    @name = name
    @side = 'White'
  end
end

class Player_two
  attr_reader :name, :side
  def initialize(name)
    @name = name
    @side = 'Black'
  end
end
