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
end

=begin


	def my_all? 
		bool=true
		self.my_each do |n|
			yield(n) ? bool : bool=false
		end
		bool
	end

	def my_any? 
		bool=false
		self.my_each do |n|
			yield(n) ? bool=true : bool
		end
		bool
	end

	def my_none?
		bool=true
		self.my_each do |n|
			yield(n) ? bool=false : bool
		end
		bool
	end

	def my_count(arg)
		count=1
		self.my_each do |n|
			if arg != n
				next	
			elsif !yield(n)
				next	
			end
			count += 1
		end
		count
	end

	def my_map(proc)
		arr=[]
		if proc && block_given?
			self.my_each {|n| arr << proc.call(yield(n))}
		elsif proc && !block_given?
			self.my_each {|n| arr << proc.call(n)}
		else
			arr = self
		end
		arr
	end

	def my_inject(memo)
		memo ||= self[0]	
		self.my_each do |n|
			memo=yield(memo,n)
		end
		memo
	end
end

def multiply_els(arr)
	arr.my_inject(1) {|memo,n| memo*n}
end 
=end