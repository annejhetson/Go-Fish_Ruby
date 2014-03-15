require './lib/game'
require './lib/player'

def new_game
  puts "Ready to play Go Fish?\n\n"
  puts "Enter Player 1 Name"
  player_1 = Player.new(gets.chomp.capitalize)
  puts "Enter Player 2 Name"
  player_2 = Player.new(gets.chomp.capitalize)
  turn = 1
  turn_player = ""
  non_turn_player = ""
  start_game(turn, player_1, player_2)
end

def start_game(turn, player_1, player_2)
  if turn.odd?
        turn_player = player_1
        non_turn_player = player_2
  else     
        turn_player = player_2
        non_turn_player = player_1
  end
  puts "****Turn Player:  #{turn_player.name} ****"
  puts "****Non Turn Player #{non_turn_player.name} ****"
  start_length = turn_player.hand.length
  puts "\n#{turn_player.name} Cards:\n"
  puts turn_player.hand
  puts "---------------------------------------------------\n"
  puts puts "\n#{non_turn_player.name} Cards:\n"
  puts non_turn_player.hand
  puts "---------------------------------------------------\n"
  puts "\n#{turn_player.name}, what card number do you want?"

  choice = gets.chomp
  @temp_array = []
  non_turn_player.hand.each do |card|
    if card[0..1].include?(choice)
      @temp_array << card
    end
  end
  
  print @temp_array
  turn_player.hand.concat(@temp_array)
  @temp_array.each do |card|
    non_turn_player.hand.reject! { |hand| hand == card}
  end
  
  if turn_player.hand.length == start_length
    puts "Go fish!¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>\n"
    puts "1 card added to #{turn_player.name}\n\n"
    turn_player.hand << Player.cards.slice!(0, 1)
    #go_fish(turn, turn_player, non_turn_player)
    turn += 1
    start_game(turn, player_1, player_2)    
  end
  start_game(turn, player_1, player_2)
end

new_game
