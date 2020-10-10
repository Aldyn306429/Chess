# frozen_string_literal: true

module Clean_String
  def translate(string)
    answer = Array.new()
    answer.push(string[0].upcase.ord - 65)
    answer.push(8 - string[1].to_i)
  end

  def check_string(array)
    return false if array[0].between?(0, 7) && array[1].between?(0, 7)
    true
  end
end