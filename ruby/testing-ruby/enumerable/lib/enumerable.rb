module Enumerable
	def my_each
		for i in 0..(self.size-1)
			yield(self[i])
		end
		self
	end

	def my_each_with_index
		for i in 0..(self.size-1)
			yield(self[i],i)
		end
		self
	end

	def my_select
		arr=[]
		self.my_each do |n|
			arr << n if yield(n)
		end
		arr
	end

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

	def my_count(arg = nil)
		count=0
		if block_given?
			self.my_each do |n|
				if yield(n)
					count += 1
				end
			end
		elsif arg
			self.my_each do |n|
				if arg == n
					count += 1
				end
			end
		else
			self.my_each do |n|
				count += 1
			end
		end
		count
	end

	def my_map(proc = nil)
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

	def my_inject(memo = nil)
		if memo
			self.my_each do |n|
				memo=yield(memo,n)
			end
		else
			memo = self[0]	
			self[1..-1].my_each do |n|
				memo=yield(memo,n)
			end
		end
		memo
	end
end

def multiply_els(arr)
	arr.my_inject(1) {|memo,n| memo*n}
end 
