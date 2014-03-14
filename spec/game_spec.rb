#require 'rspec'
require 'game'

describe Game do
  it 'initializes a game instance' do
    test_game = Game.new(2, false)
    test_game.should be_an_instance_of Game
  end

  it 'initializes a game with number of players and game status' do
    test_game = Game.new(2, false)
    test_game.num_players.should eq 2
    test_game.game_over.should eq false
  end

  # describe '.create' do
  #   it 'creates a new game with 5 cards dealt to each player' do
  #     test_game = Game.create(2, false)

end
