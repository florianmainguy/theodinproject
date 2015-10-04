require './lib/tic-tac-toe.rb'

describe TicTacToe do
  
  before :all do
    @game = TicTacToe.new
  end
   
  describe '#victory' do
    it 'returns true for 3 X at the top' do
      @table = { :a1 => "X", :a2 => "X", :a3 => "X",
                 :b1 => " ", :b2 => " ", :b3 => " ",
                 :c1 => " ", :c2 => " ", :c3 => " " }
      @game.victory?("X").should eql true
    end
  end
end