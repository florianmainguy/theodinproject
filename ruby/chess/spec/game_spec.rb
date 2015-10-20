require './lib/game.rb'

describe Game do

  let (:game) { Game.new }
  let (:flo) { Player.new("flo", "white") }
  let (:ginny) { Player.new("ginny", "black") }

  describe '#case_not_valid?' do
    context "when input is 'from'" do
      let (:input) { 'from'}
      it "returns false if a selected case is valide" do
        case_selected = [1,1]
        game.stub(:current_player) { flo }
        expect(game.case_not_valid?(case_selected, input)).to eq false
      end
      it "returns true if a case is empty" do
        case_selected = [3,3]
        game.stub(:current_player) { flo }
        expect(game.case_not_valid?(case_selected, input)).to eq true
      end
      it "returns true if the case is taken by an adverse piece" do
        case_selected = [7,7]
        game.stub(:current_player) { flo }
        expect(game.case_not_valid?(case_selected, input)).to eq true
      end
    end

    context "when input is 'to'" do
      let (:input) { 'to'}
      it "returns false if a selected case is valide" do
        case_selected = [3,3]
        expect(game.case_not_valid?(case_selected, input)).to eq false
      end
      it "returns true if the case is already taken by own piece" do
        case_selected = [1,1]
        game.stub(:current_player) { flo }
        expect(game.case_not_valid?(case_selected, input)).to eq true
      end
    end
  end


  describe '#move_possible' do
    context "regards to piece's way of displacement" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[1][0] = Knight.new('white', [1,0], 'step')
        array[2][0] = Bishop.new('white', [2,0], 'slide')
        array[3][0] = Queen.new('white', [3,0], 'slide')
        array[4][0] = King.new('white', [4,0], 'step')
        array[5][1] = Pawn.new('white', [5,1], 'step')
        array[7][7] = King.new('black', [7,7], 'step')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if rook can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([0,0], [0,1]).first).to eq true
      end
      it "returns an array with 1st element eq to false if rook can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([0,0], [1,1]).first).to eq false
      end
      it "returns an array with 1st element eq to true if knight can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([1,0], [0,2]).first).to eq true
      end
      it "returns an array with 1st element eq to false if knight can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([1,0], [0,1]).first).to eq false
      end
      it "returns an array with 1st element eq to true if bishop can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([2,0], [3,1]).first).to eq true
      end
      it "returns an array with 1st element eq to false if bishop can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([2,0], [2,1]).first).to eq false
      end
      it "returns an array with 1st element eq to true if queen can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,0], [3,3]).first).to eq true
      end
      it "returns an array with 1st element eq to false if queen can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,0], [4,2]).first).to eq false
      end
      it "returns an array with 1st element eq to true if king can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([4,0], [4,1]).first).to eq true
      end
      it "returns an array with 1st element eq to false if king can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([4,0], [4,2]).first).to eq false
      end
      it "returns an array with 1st element eq to true if pawn can move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([5,1], [5,2]).first).to eq true
      end
      it "returns an array with 1st element eq to false if pawn can't move" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([5,1], [6,1]).first).to eq false
      end
    end

    context "regards to sliding pieces" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[3][1] = Rook.new('white', [3,1], 'slide')
        array[3][2] = Bishop.new('white', [3,2], 'slide')
        array[4][1] = Queen.new('white', [4,1], 'slide')
        array[7][7] = King.new('black', [7,7], 'step')
        Board.new(array)
      end
      it "returns an array with 1st element eq to false if obstacle on the path" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,1], [5,1]).first).to eq false
        expect(game.move_possible([3,2], [5,0]).first).to eq false
        expect(game.move_possible([4,1], [2,1]).first).to eq false
      end
    end
    
    context "regards to the pawn" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[0][0] = King.new('white', [0,0], 'step')
        array[2][1] = Pawn.new('white', [2,1], 'step')
        array[3][2] = Pawn.new('white', [3,2], 'step')
        array[4][3] = Pawn.new('black', [4,3], 'step')
        array[7][7] = King.new('black', [7,7], 'step')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if pawn can double displacement" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([2,1], [2,3]).first).to eq true
      end
      it "returns an array with 1st element eq to true if pawn can go in diag" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,2], [4,3]).first).to eq true
      end
      it "returns an array with 1st element eq to false if pawn can't double displacement" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,2], [3,4]).first).to eq false
      end
      it "returns an array with 1st element eq to false if pawn can't go in diag" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([2,1], [1,2]).first).to eq false
      end
    end

    context "regards to kings location" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[3][3] = King.new('white', [3,3], 'step')
        array[3][5] = King.new('black', [3,5], 'step')
        Board.new(array)
      end
      it "returns an array with 1st element eq to false if kings are one case apart" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([3,5], [3,4]).first).to eq false
      end
    end

    context "regards to own king" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[0][0] = King.new('white', [0,0], 'step')
        array[7][7] = King.new('black', [7,7], 'step')
        array[6][0] = Queen.new('white', [6,0], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to false if king becomes in check" do
        game.stub(:board) { board }
        game.stub(:current_player) { ginny }
        game.stub(:other_player) { flo }
        expect(game.move_possible([7,7], [6,7]).first).to eq false
      end
    end

    context "regards to castling, left bottom" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[7][0] = Rook.new('white', [7,0], 'slide')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][7] = Rook.new('black', [0,7], 'slide')
        array[7][7] = Rook.new('black', [7,7], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if king can castle" do
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        game.stub(:board) { board }
        expect(game.move_possible([4,0], [2,0]).first).to eq true
      end
    end
    context "regards to castling, right bottom" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[7][0] = Rook.new('white', [7,0], 'slide')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][7] = Rook.new('black', [0,7], 'slide')
        array[7][7] = Rook.new('black', [7,7], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if king can castle" do
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
         game.stub(:board) { board }
        expect(game.move_possible([4,0], [6,0]).first).to eq true
      end
    end
    context "regards to castling, left top" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[7][0] = Rook.new('white', [7,0], 'slide')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][7] = Rook.new('black', [0,7], 'slide')
        array[7][7] = Rook.new('black', [7,7], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if king can castle" do
        game.stub(:current_player) { ginny }
        game.stub(:other_player) { flo }
        game.stub(:board) { board }
        expect(game.move_possible([4,7], [2,7]).first).to eq true
      end
    end
    context "regards to castling, right up" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[7][0] = Rook.new('white', [7,0], 'slide')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][7] = Rook.new('black', [0,7], 'slide')
        array[7][7] = Rook.new('black', [7,7], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to true if king can castle" do
        game.stub(:current_player) { ginny }
        game.stub(:other_player) { flo }
         game.stub(:board) { board }
        expect(game.move_possible([4,7], [6,7]).first).to eq true
      end
    end
    context "regards to castling" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[0][0] = Rook.new('white', [0,0], 'slide')
        array[5][0] = Queen.new('white', [5,0], 'slide')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][7] = Rook.new('black', [0,7], 'slide')
        array[3][7] = Queen.new('black', [3,7], 'slide')
        Board.new(array)
      end
      it "returns an array with 1st element eq to false if king can't castle" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        expect(game.move_possible([4,0], [2,0]).first).to eq false
      end
    end
  end

  describe '#king_check?' do  
    context "if check by a rook" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[4][7] = King.new('black', [4,7], 'step')
        array[0][0] = Rook.new('black', [0,0], 'slide')
        Board.new(array)
      end
      it "returns an array" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        king = board.get_case([4,0])
        expect(game.king_check?(king)).to be_kind_of(Rook)
      end
    end

    context "if check by a knight" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[4][7] = King.new('black', [4,7], 'step')
        array[3][2] = Knight.new('black', [3,2], 'step')
        Board.new(array)
      end
      it "returns an array" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        king = board.get_case([4,0])
        expect(game.king_check?(king)).to be_kind_of(Knight)
      end
    end

    context "if check by a bishop" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[4][7] = King.new('black', [4,7], 'step')
        array[3][1] = Bishop.new('black', [3,1], 'slide')
        Board.new(array)
      end
      it "returns an array" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        king = board.get_case([4,0])
        expect(game.king_check?(king)).to be_kind_of(Bishop)
      end
    end

    context "if check by a queen" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[4][7] = King.new('black', [4,7], 'step')
        array[4][4] = Queen.new('black', [4,4], 'slide')
        Board.new(array)
      end
      it "returns an array" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        king = board.get_case([4,0])
        expect(game.king_check?(king)).to be_kind_of(Queen)
      end
    end

    context "if check by a bishop" do
      let(:board) do
        array = Array.new(8) { Array.new(8) }
        array[4][0] = King.new('white', [4,0], 'step')
        array[4][7] = King.new('black', [4,7], 'step')
        array[3][1] = Pawn.new('black', [3,1], 'step')
        Board.new(array)
      end
      it "returns an array" do
        game.stub(:board) { board }
        game.stub(:current_player) { flo }
        game.stub(:other_player) { ginny }
        king = board.get_case([4,0])
        expect(game.king_check?(king)).to be_kind_of(Pawn)
      end
    end
  end

  describe '#victory' do
    let(:board) do
      array = Array.new(8) { Array.new(8) }
      array[0][1] = Pawn.new('white', [0,1], 'step')
      array[1][1] = Pawn.new('white', [1,1], 'step')
      array[2][1] = Pawn.new('white', [2,1], 'step')
      array[0][0] = King.new('white', [0,0], 'step')
      array[4][7] = King.new('black', [4,7], 'step')
      array[5][0] = Queen.new('black', [5,0], 'slide')
      Board.new(array)
    end
    it 'returns true if there is chekmate' do
      game.stub(:board) { board }
      game.stub(:current_player) { flo }
      game.stub(:other_player) { ginny }
      expect(game.victory?).to be true
    end
  end

  describe '#draw' do
    let(:board) do
      array = Array.new(8) { Array.new(8) }
      array[0][0] = King.new('white', [0,0], 'step')
      array[4][7] = King.new('black', [4,7], 'step')
      Board.new(array)
    end
    it 'returns true if draw' do
      game.stub(:board) { board }
      game.stub(:current_player) { ginny }
      game.stub(:other_player) { flo }
      expect(game.draw?).to be true
    end
  end

  describe '#stalemate' do
    let(:board) do
      array = Array.new(8) { Array.new(8) }
      array[0][0] = King.new('white', [0,0], 'step')
      array[4][7] = King.new('black', [4,7], 'step')
      array[1][7] = Queen.new('black', [1,7], 'slide')
      array[5][1] = Rook.new('black', [5,1], 'slide')
      Board.new(array)
    end
    it 'returns true if stalemate' do
      game.stub(:board) { board }
      game.stub(:current_player) { flo }
      game.stub(:other_player) { ginny }
      expect(game.stalemate?).to be true
    end
  end
end