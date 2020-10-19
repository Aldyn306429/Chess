# frozen_string_literal: true

require 'yaml'

def save_game(data)
  Dir.mkdir('saved_games') unless Dir.exists?('saved_games')
  puts "\nEnter name for saved game: "
  response = gets.chomp.strip
  filename = "saved_games/#{response}.yaml"
  file = File.open("#{filename}", 'w')
  file.puts YAML.dump(data)
  file.close
  puts "\nSaving Game..."
  sleep(0.6)
  puts "\nGame Saved!"
end

def load_game
  unless Dir.exists?('saved_games')
    puts "\nNo saved games available"
    return false
  end

  file = Dir.entries('saved_games')
  if file.size < 3
    puts "\nNo saved games available"
    exit
  end
  puts "\nSelect a game below to load"
  puts "\n"
  file_cnt = 1
  file.each do |file|
    next if file == "." || file == ".."
    puts "#{file_cnt}. #{File.basename(file, ".yaml")}"
    file_cnt += 1
  end
  
  puts "\nInput game name: "
  response = gets.chomp
  while !Dir.entries('saved_games').include?("#{response}.yaml")
    puts "\nGame doesn't exist"
    puts "Input game: "
    response = gets.chomp
  end

  info = File.open("saved_games/#{response}.yaml", 'r')
  data = YAML.load(info)
  @player1 = data[:player_one]
  @player2 = data[:player_two]
  @board = data[:board]
  @king_in_check = data[:king_check]
  @round_number = data[:rNumber]

  start_game
end