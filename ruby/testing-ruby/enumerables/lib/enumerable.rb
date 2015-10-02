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
