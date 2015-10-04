require './lib/enumerable.rb'

describe Enumerable do

	let(:array) {[1, 2, 3]}

	before :each do
		@test = []
	end

	describe '#my_each' do
		it 'applies a block to each element of an array' do
			array.my_each { |element| @test << element }
			@test.should eql array
		end

		it 'doesn t override an array' do
			array.my_each { |element| element * 4 }
			array.should eql [1, 2, 3]
		end
	end

	describe 'my_each_with_index' do
		it 'applies a block to each element of an array' do
			array.my_each_with_index { |element, index| @test << element }
			@test.should eql array
		end

		it 'passes the index of each element' do
			array.my_each_with_index { |element, index| @test << element if index%2 == 0 }
			@test.should eql [1, 3]
		end
	end

	describe 'my_select' do
		it 'selects some elements of an array' do
			@test = array.my_select { |element| element%2 == 0 }
			@test.should eql [2]
		end

		it 'returns an empty array if no elements match' do
			@test = array.my_select { |element| element%5 == 0 }
			@test.should eql []
		end
	end

	describe 'my_all' do
		it 'returns true if all elements of an array match the condition given in a block' do
			expect(array.my_all? { |element| element.is_a? Numeric }).to eql true
		end

		it 'returns false if one element or more dont match the condition' do
			expect(array.my_all? { |element| element.is_a? String }).to eql false
		end
	end

	describe 'my_any' do
		it 'returns true if one element or more of an array match the condition given in a block' do
			expect(array.my_any? { |element| element == 1 }).to eql true
		end

		it 'returns false if all elements dont match the condition' do
			expect(array.my_all? { |element| element == 4 }).to eql false
		end
	end

	describe 'my_none' do
		it 'returns true if no elements match the condition given in a block' do
			expect(array.my_none? { |element| element.is_a? String }).to eql true
		end

		it 'returns false if one element doesnt match the condition' do
			expect(array.my_none? { |element| element == 1 }).to eql false
		end
	end

	describe 'my_count' do
		context 'with an argument given' do
			it 'counts the number of items in an array' do
				array.my_count(2).should eql 1
			end
		end

		context 'whit a block given' do
			it 'counts the number of items matching the condition'do
				expect(array.my_count { |element| element.is_a? Numeric }).to eql 3
		  end
		end
	end

	describe 'my_map' do
		proc = Proc.new { |i| i*2 }

		context 'with a block given' do
			context 'but no proc' do
				it 'returns the array' do
					expect(array.my_map { |element| element/2 }).to eql array
				end
			end
			
			context 'and a proc' do
				it 'executes the proc and the block' do
					expect(array.my_map(proc) { |element| element*2 }).to eql [4, 8, 12]
				end
			end
		end

		context 'with no block given' do
			it 'executes the proc' do
					expect(array.my_map(proc)).to eql [2, 4, 6]
			end
		end
	end

	describe 'my_inject' do
		it 'add all elements of an array' do
			expect(array.my_inject { |memo, element| memo + element }).to eql 6
		end	

		it 'takes an initial value for the memo' do
			expect(array.my_inject(4) { |memo, element| memo + element }).to eql 10
		end
	end

	describe 'multiply_els' do
		it 'multiplies the elements of an array' do
			expect(multiply_els(array)).to eql 6
		end
	end
end