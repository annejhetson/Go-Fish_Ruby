require 'rspec'
require 'player'

describe Player do
  it 'initializes a player instance' do
    test_player = Player.new("Mark", ["Ace of Hearts", "3 of Clubs", "5 of Diamonds", "5 of Clubs", "King of Spades"])
    test_player.should be_an_instance_of Player
  end

  it 'initializes with a value' do
    test_player = Player.new("Mark", ["Ace of Hearts", "3 of Clubs", "5 of Diamonds", "5 of Clubs", "King of Spades"])
    test_player.name.should eq "Mark"
    test_player.hand.should eq ["Ace of Hearts", "3 of Clubs", "5 of Diamonds", "5 of Clubs", "King of Spades"]
  end

#   describe '.create' do

end
