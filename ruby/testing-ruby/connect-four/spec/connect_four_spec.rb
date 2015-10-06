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
  describe '#initialize' do
    it "is initialized with a color of '' by default" do
      cell = CellNode.new
      expect(cell.color).to eq ''
    end

    ### usefull ????? ###
    it "can be initialized with a color of 'red'" do
      cell = CellNode.new("red")
      expect(cell.color).to eq "red"
    end
  end
end
