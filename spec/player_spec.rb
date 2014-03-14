require 'rspec'
require 'player'

describe Player do
  it 'initializes a player instance' do
    test_player = Player.new("Bob")
    test_player.should be_an_instance_of Player
  end

  it 'initializes with a value' do
    test_player = Player.new("Bob")
    test_player.name.should eq "Bob"
    test_player.hand.size.should eq 5
  end
end
