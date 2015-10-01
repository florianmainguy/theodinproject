require './lib/caesar_cipher.rb'

describe "#caesar_cipher" do

  it 'shifts a word by a positif number' do
    caesar_cipher("test", 5).should eql "yjxy"
  end 

  it 'shifts a word by a negatif number' do
    caesar_cipher("test", -4).should eql "paop"
  end   

  it 'returns to a after z' do
    caesar_cipher("z", 1).should eql "a"
  end 

  it 'returns to z before a' do
    caesar_cipher("a", -1).should eql "z"
  end 

  it 'keeps capital letters and special caracters' do
    caesar_cipher("Yes! Yes!", 1).should eql "Zft! Zft!"
  end

  it "shifts by a big key" do
    caesar_cipher("What a string!", 1305).should eql "Bmfy f xywnsl!"
  end
end