require './lib/connect_four.rb'

describe Player do
  describe '#initialize' do
    it 'raises an error if called without argument' do
      expect { Player.new }.to raise_error
    end
  end
end