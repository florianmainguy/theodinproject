require '../lib/caesar_cipher.rb'

describe "#caesar_cipher" do

  it 'shifts by a given number' do
    caesar_cipher("Test", 5).should eql "Yjxy"
  end 

  
end