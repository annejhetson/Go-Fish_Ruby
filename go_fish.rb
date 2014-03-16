require './lib/game'
require './lib/player'

def new_game
  puts "Ready to play Go Fish?¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>\n\n"
  #puts "Press 1: Computer will be your opponent"
  #puts "Press2: I'm playing with my friend"
  puts "Enter Player 1 Name"
  player_1 = Player.new(gets.chomp.capitalize)
  puts "Enter Player 2 Name OR 'COMP' to play with computer"
  name = gets.chomp
  if name == "comp"
    player_2 = Player.new("Awesome-O.0.1")
  else
    player_2 = Player.new(name.capitalize)
  end
  
  turn = 1
  turn_player = ""
  non_turn_player = ""
  player_1_score = 0
  player_2_score = 0
  awesome_memory = []
  start_game(turn, player_1, player_2, player_1_score, player_2_score, awesome_memory)
end

def start_game(turn, player_1, player_2, player_1_score, player_2_score, awesome_memory)
  
  if turn.odd?
        turn_player = player_1
        non_turn_player = player_2
  else     
        turn_player = player_2
        non_turn_player = player_1
  end
  start_length = turn_player.hand.length # << Set number of cards in turn_player's hand.
  
  puts "****Turn Player:  #{turn_player.name} ****"
  puts "****Non Turn Player #{non_turn_player.name} ****"
  
  puts "\n#{turn_player.name} Cards:\n"
  print turn_player.hand.sort do |a,b| a <=> b end
  puts "\n---------------------------------------------------\n"
  puts puts "#{non_turn_player.name} Cards:\n"
  print non_turn_player.hand.sort do |a,b| a <=> b end
  puts "\n---------------------------------------------------\n"
  puts "\n#{turn_player.name}, what card number do you want?"
  puts "Enter 'J' for Jack, 'Q' for Queen, 'K' for King and 'A' for Ace"
 
  if turn_player.name == "Awesome-O.0.1" ##&& awesome_memory.count > 0 && ## memory matach hand
    choice = turn_player.hand.sample[0..1]
  #elsif
   # turn_player.name == "Awesome-O.0.1"
    #choice = turn_player.hand.sample[0..1]
  else
    choice = gets.chomp
  end
  
  #if turn_player = player_1
  # awesome_memory << choice ##<< awesome_memory keeps track of another player's cards
  #end
  
  puts "Do you have any #{choice}?"
  puts "*Press Enter*"
  gets
  
  @temp_array = []
  non_turn_player.hand.each do |card|
      if card[0..1].include?(choice)
         @temp_array << card
      end
  end
  
  if @temp_array.length > 0
    puts "Oh boy! I do"
    puts "*Press Enter*"
    gets
    turn_player.hand.concat(@temp_array) #<< Add card(s) to turn_player's hand
    @temp_array.each do |card|
      non_turn_player.hand.reject! { |hand| hand == card} #<< Remove card(s) from non_player's hand
    end
    check_winning(turn, turn_player, non_turn_player, player_1, player_2, player_1_score, player_2_score, awesome_memory)
  else
     go_fish(turn, turn_player, non_turn_player, player_1, player_2, player_1_score, player_2_score, awesome_memory)
  end
  
end

def go_fish(turn, turn_player, non_turn_player, player_1, player_2, player_1_score, player_2_score, awesome_memory)  
    puts "Go fish!¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>\n"
    puts "1 card added to #{turn_player.name}\n\n"
    turn_player.hand << Player.cards.slice!(0, 1).join("")
    puts "There are #{Player.cards.count} left in the pile"
    puts "*Press Enter*"
    gets
    turn += 1
    check_winning(turn, turn_player, non_turn_player, player_1, player_2, player_1_score, player_2_score, awesome_memory) 
end

def check_winning(turn, turn_player, non_turn_player, player_1, player_2, player_1_score, player_2_score, awesome_memory)
  @four_card_array = []
  @card_number = ""
  @temp_array = []
  
  turn_player.hand.each {|card| @temp_array << card}
  @temp_array.map!{|card| card[0..1]} #<< Put first 2 positions of all elements in temp_array
  
  if @temp_array.detect{|e|@temp_array.count(e) == 4} #If there are 4 matching card number, say Yea! :)
    puts "¸¸♬·¯·♩¸¸♪·¯·♫¸¸Yeah!!¸¸♬·¯·♩¸¸♪·¯·♫¸¸\n"
    @card_number =  @temp_array.detect{|e|@temp_array.count(e) == 4} 
    puts "I got full suit of #{@card_number}\n"
    
    turn_player.hand.each do |card|
      if @card_number.include?card[0..1]
          @four_card_array << card
      end
    end
    
    puts "These are my 4 cards"
    print "#{@four_card_array}\n" #<< Show his/her 4 of the kind
    puts "*Press Enter*"
    gets
    
    @four_card_array.each do |card|
      turn_player.hand.reject! { |hand| hand == card} #<< Remove 4 of the kind off player's hand
    end
    
    puts "#{turn_player.name} takes #{@card_number} cards off her/his hand}\n"
       
    if turn_player = player_1
      player_1_score += 1
      puts "Score has been added to #{player_1.name}"
      puts "Player1 Score: #{player_1_score}"
      puts "Player2 Score: #{player_2_score}"
    else
      player_2_score += 1
      puts "Score has been added to #{player_2.name}"
      puts "#{player_1.name} Score: #{player_1_score}"
      puts "#{player_2.name} Score: #{player_2_score}"
    end
    
  end
  
   if player_1.hand.count == 0 || Player.cards.count == 0 || player_2.hand.count == 0
     game_over(player_1, player_2, player_1_score, player_2_score)
   else       
     start_game(turn, player_1, player_2, player_1_score, player_2_score, awesome_memory)
   end
end

def game_over(player_1, player_2, player_1_score, player_2_score)
   puts "GAME OVER"
   puts "Player1 Score: #{player_1_score}"
   puts "Player2 Score: #{player_2_score}"
end
new_game
