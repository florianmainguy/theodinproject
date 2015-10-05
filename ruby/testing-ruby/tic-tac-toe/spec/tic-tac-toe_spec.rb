# This Rspec excercise made me changed my Tic Tac Toe program.

# I improved the fact that each method should have its own purpose. It is much easier
# to test this way. And it's easier to read throught.

require './lib/tic-tac-toe.rb'

describe TicTacToe do
  
  before :each do
    @game = TicTacToe.new
    @player1 = Player.new('flo', 0, 'X')
    @player2 = Player.new('flo', 0, 'O')
  end
  
  describe '#case_chosen' do
    it 'returns the case selected' do 
      @game.stub(:gets).and_return('c1')
      expect(@game.case_chosen(@player1)).to eql :c1
    end
  end

  describe '#handle_selection' do
    it 'returns true if the case selected is available' do
      expect(@game.handle_selection('c1')).to be_true
    end

    it 'returns false if the case selected is already taken' do
      @game.board(:c1, @player1.symbol)
      expect(@game.handle_selection('c1')).to be_false
    end

    it 'returns false if the case selected is not a case' do
      expect(@game.handle_selection('potato')).to be_false
    end
  end

  describe '#board' do
    it 'reads the case passed if only argument' do
      expect(@game.board(:b3)).to eql ' '
    end

    it 'fills the case passed by the player symbol' do
      @game.board(:b2, @player1.symbol)
      expect(@game.board(:b2)).to eql @player1.symbol
    end
  end

  describe '#victory' do
    it 'returns true for 3 X at the top' do
      @game.board(:a1, @player1.symbol)
      @game.board(:b1, @player1.symbol)
      @game.board(:c1, @player1.symbol)
      expect(@game.victory?('X')).to be_true
    end

    it 'returns true for 3 O in diagonal' do
      @game.board(:a3, @player2.symbol)
      @game.board(:b2, @player2.symbol)
      @game.board(:c1, @player2.symbol)
      expect(@game.victory?('O')).to be_true
    end

    it 'returns false if a player didnt win' do
      expect(@game.victory?('O')).to be_false
    end
  end
end