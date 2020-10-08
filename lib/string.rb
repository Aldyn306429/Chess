# frozen_string_literal: true

module Clean_String
  def translate(string)
    answer = Array.new()
    answer.push(string[0].upcase.ord - 65)
    answer.push(string[1].to_i - 1)
  end

  def check_string(string)

  end
end