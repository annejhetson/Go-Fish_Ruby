require './lib/game'
require './lib/card'
require './lib/player'

def new_game
  puts "Read to play Go Fish?\n\n"
  puts "Enter Player 1 Name"
  player_1 = Player.new(gets.chomp.capitalize)
  puts "Enter Player 2 Name"
  player_2 = Player.new(gets.chomp.capitalize)
  start_game(1, player_1, player_2)
end

def start_game(turn, player_1, player_2)
  turn_player = ""
  non_turn_player = ""
  if turn % 2 == 1
    turn_player = player_1
    non_turn_player = player_2
  else
    turn_player = player_2
    non_turn_player = player_1
  end
  start_length = turn_player.hand.length
  puts "\n#{turn_player.name} Cards:\n"
  puts turn_player.hand
  puts "---------------------------------------------------\n"
  puts puts "\n#{non_turn_player.name} Cards:\n"
  puts non_turn_player.hand
  puts "---------------------------------------------------\n"
  puts "\n#{turn_player.name}, what card number do you want?"

  choice = gets.chomp
  non_turn_player.hand.each do |card|
    puts card
    if card[0..1].include?(choice) || card[0].include?(choice)
      turn_player.hand << card
      non_turn_player.hand.delete(card)
      # go back one on the array
    end
  end
  puts "\n\n#{turn_player.name} Cards:\n"
  puts turn_player.hand
  puts "---------------------------------------------------\n"
  puts puts "\n\n#{non_turn_player.name}  Cards:\n"
  puts non_turn_player.hand
  puts "---------------------------------------------------\n"

  if turn_player.hand.length == start_length
    puts "Go fish!"
    go_fish(turn, turn_player, non_turn_player)
    turn += 1
  end
  start_game(turn, player_1, player_2)
end

def go_fish(turn, turn_player, non_turn_player)
  turn_player.hand << Player.cards.slice!(0, 1)
  puts "\n#{turn_player.name} Cards:\n"
  puts turn_player.hand
  puts "---------------------------------------------------\n"
  puts Player.cards.length
  turn += 1
  start_game(turn, turn_player, non_turn_player)
end

new_game
