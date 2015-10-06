require './lib/connect_four.rb'



describe Player do
  describe '#initialize' do
    it 'raises an error if called without argument' do
      expect { Player.new }.to raise_error
    end

    it "does not raise an error when initialized with a valid input hash" do
      input = { color: "red", name: "Flo" }
      expect { Player.new(input) }.to_not raise_error
    end

    context "#name" do
      it "returns the player's name" do
        input = { color: "red", name: "Flo" }
        player = Player.new(input)
        expect(player.name).to eq "Flo"
      end
    end

    context "#color" do
      it "returns the color" do
        input = { color: "red", name: "Flo" }
        player = Player.new(input)
        expect(player.color).to eq "red"
      end
    end
  end
end



describe CellNode do
  before :each do
    @cell = CellNode.new
  end

  describe '#initialize' do
    it "is initialized with a color of '' by default" do
      expect(@cell.color).to eq ''
    end

    ### usefull ????? ###
    it "can be initialized with a color of 'red'" do
      cell = CellNode.new("red")
      expect(cell.color).to eq "red"
    end
  end

  context "#left" do
    it "writes and returns 'left'" do
      @cell.left = 'left'
      expect(@cell.left).to eq "left"
    end
  end

  context "#right" do
    it "writes and returns 'right'" do
      @cell.right = 'right'
      expect(@cell.right).to eq "right"
    end
  end

  context "#down" do
    it "writes and returns 'down'" do
      @cell.down = 'down'
      expect(@cell.down).to eq "down"
    end
  end

  context "#up" do
    it "writes and returns 'up'" do
      @cell.up = 'up'
      expect(@cell.up).to eq "up"
    end
  end

  context "#diag_lu" do
    it "writes and returns 'diag_lu'" do
      @cell.diag_lu = 'diag_lu'
      expect(@cell.diag_lu).to eq "diag_lu"
    end
  end

  context "#diag_ld" do
    it "writes and returns 'diag_ld'" do
      @cell.diag_ld = 'diag_ld'
      expect(@cell.diag_ld).to eq "diag_ld"
    end
  end

  context "#diag_ru" do
    it "writes and returns 'diag_ru'" do
      @cell.diag_ru = 'diag_ru'
      expect(@cell.diag_ru).to eq "diag_ru"
    end
  end

  context "#diag_rd" do
    it "writes and returns 'diag_rd'" do
      @cell.diag_rd = 'diag_rd'
      expect(@cell.diag_rd).to eq "diag_rd"
    end
  end
end



describe Board do
  before :each do
    @board = Board.new
  end

  describe '#initialize' do
    it "initializes the board" do
      expect { Board.new }.to_not raise_error
    end

    it "sets the grid with 7 columns" do
      expect(@board.grid).to have(7).things
    end

    it "creates 6 rows in each column" do
      @board.grid.each do |columns|
        expect(columns).to have(6).things
      end
    end
  end

  context '#grid'
    it "returns the grid" do
    board = Board.new("blah")
    expect(board.grid).to eq "blah"
  end

  describe 'get_cell' do
    it "returns the cell based on the (x, y) coordinate" do
      grid = [['', '', '', '', '', ''], ['', '', 'something', '', '', ''], 
              ['', '', '', '', '', ''], ['', '', '', '', '', ''], ['', '', '', '', '', ''],
              ['', '', '', '', '', ''], ['', '', '', '', '', ''], ['', '', '', '', '', '']]
      board = Board.new(grid)
      expect(board.get_cell(1, 2)).to eq "something"
    end
  end

  describe 'set_cell' do
    it "updates the color of the cell object at (x, y) coordinate" do
      Cat = Struct.new(:color)
      grid = [[Cat.new('orange'), '', '', '', '', ''], ['', '', '', '', '', ''], 
              ['', '', '', '', '', ''], ['', '', '', '', '', ''], ['', '', '', '', '', ''],
              ['', '', '', '', '', ''], ['', '', '', '', '', ''], ['', '', '', '', '', '']]
      board = Board.new(grid)
      board.set_cell(0, 0, "green")
      expect(board.get_cell(0, 0).color).to eq "green"
    end
  end

  describe '#game_over' do
    #TestCell = Struct.new(:color)
    #let(:x) { TestCell.new('X') }
    #let(:y) { TestCell.new('Y') }
    #let(:o) { TestCell.new }
    let(:x) { CellNode.new('X') }
    let(:y) { CellNode.new('Y') }
    let(:o) { CellNode.new }

    it "returns :winner if winner? is true" do
      @board.stub(:winner?) { true }
      expect(@board.game_over).to eq :winner
    end
 
    it "returns :draw if winner? is false and draw? is true" do
      @board.stub(:winner?) { false }
      @board.stub(:draw?) { true }
      expect(@board.game_over).to eq :draw
    end
 
    it "returns false if winner? is false and draw? is false" do
      @board.stub(:winner?) { false }
      @board.stub(:draw?) { false }
      expect(@board.game_over).to be_false
    end

    it "returns :draw when all spaces on the board are taken" do
      grid = [[x, x, y, y, x, x], [y, y, x, x, y, y], [x, x, y, y, x, x], [y, y, x, x, y, y],
              [x, x, y, y, x, x], [y, y, x, x, y, y], [x, x, y, y, x, x]]
      board = Board.new(grid)
      board.last_cell_played = board.get_cell(1, 2)
      expect(board.game_over).to eq :draw
    end

    it "returns :winner when there is 4 cells of the same color horizontaly" do
      grid = [[o, o, o, o, o, o], [o, x, x, x, x, o], [o, o, o, o, o, o], [o, o, o, o, o, o],
              [o, o, o, o, o, o], [o, o, o, o, o, o], [o, o, o, o, o, o]]
      board = Board.new(grid)
      expect(board.game_over).to eq :winner
    end
 
    it "returns :winner when there is 4 cells of the same color verticaly" do
      grid = [[o, o, o, o, o, o], [o, y, o, o, o, o], [o, y, o, o, o, o], [o, y, o, o, o, o],
              [o, y, o, o, o, o], [o, o, o, o, o, o], [o, o, o, o, o, o]]
      board = Board.new(grid)
      expect(board.game_over).to eq :winner
    end
 
    it "returns :winner when there is 4 cells of the same color diagonally" do
      grid = [[o, x, o, o, o, o], [o, o, x, o, o, o], [o, o, o, x, o, o], [o, o, o, o, x, o],
              [o, o, o, o, o, o], [o, o, o, o, o, o], [o, o, o, o, o, o]]
      board = Board.new(grid)
      expect(board.game_over).to eq :winner
    end
  end
end