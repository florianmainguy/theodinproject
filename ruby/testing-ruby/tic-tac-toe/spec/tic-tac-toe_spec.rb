require './lib/tic-tac-toe.rb'

describe TicTacToe do
  
  before :each do
    @game = TicTacToe.new
    @player = Player.new('flo', 0, 'X')
  end
  
  describe '#case_chosen' do
    it 'returns the case selected' do 
      @game.stub(:get_board).and_return({ :a1 => "X", :a2 => "O", :a3 => "X",
                                          :b1 => " ", :b2 => "O", :b3 => " ",
                                          :c1 => " ", :c2 => "X", :c3 => " " })
      @game.stub(:select) {'c1'}
      @game.case_chosen(@player).should eql 'c1'
    end

    it 'asks the player to select again if case already taken' do
      @game.stub(:get_board).and_return({ :a1 => "X", :a2 => "O", :a3 => "X",
                                          :b1 => " ", :b2 => "O", :b3 => " ",
                                          :c1 => " ", :c2 => "X", :c3 => " " })
      @game.stub(:select) {'a1'}
      @game.stub(:case_ok) {true}
      @game.case_chosen(@player)
      expect(@game).to receive(:puts).with('Case already played ! Select another one:')
    end

    it 'asks the player to select again if player gave wrong input' do
      @game.stub(:get_board).and_return({ :a1 => "X", :a2 => "O", :a3 => "X",
                                          :b1 => " ", :b2 => "O", :b3 => " ",
                                          :c1 => " ", :c2 => "X", :c3 => " " })
      @game.stub(:select) {'potato'}
      @game.stub(:case_ok) {true}
      @game.case_chosen(@player)
      expect(@game.case_chosen(@player)).to receive(:puts).with("Sorry I didn't understand. Which case ? (ex: a2, c3, b1)")
    end
  end

  describe '#victory' do
    it 'returns true for 3 X at the top' do
      @game.stub(:get_board).and_return({ :a1 => "X", :a2 => "X", :a3 => "X",
                                          :b1 => " ", :b2 => " ", :b3 => " ",
                                          :c1 => " ", :c2 => " ", :c3 => " " })
      @game.victory?("X").should eql true
    end

    it 'returns true for 3 O in diagonal' do
      @game.stub(:get_board).and_return({ :a1 => " ", :a2 => " ", :a3 => "O",
                                          :b1 => " ", :b2 => "O", :b3 => " ",
                                          :c1 => "O", :c2 => " ", :c3 => " " })
      @game.victory?("O").should eql true
    end

    it 'returns false if a player didnt win and the board is full' do
      @game.stub(:get_board).and_return({ :a1 => "X", :a2 => "O", :a3 => "X",
                                          :b1 => "O", :b2 => "X", :b3 => "X",
                                          :c1 => "O", :c2 => "X", :c3 => "O" })
      @game.victory?("O").should eql false
    end
  end
end