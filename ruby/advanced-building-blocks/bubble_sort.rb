=begin
Build a method #bubble_sort that takes an array and returns a sorted array.
It must use the bubble sort methodology (using #sort would be pretty pointless,
wouldn't it?).

    > bubble_sort([4,3,78,2,0,2])
    => [0,2,2,3,4,78]
=end


def bubble_sort(array)
  no_pb = false
  while !no_pb
    no_pb = true
    array.each_with_index do |number,index|
      unless index == array.length-1
        if number<=array[index+1] 
		  temp1=array[index]
		  temp2=array[index+1]
        else
		  temp1=array[index+1]
		  temp2=array[index]
		  no_pb = false
        end
  	    array[index]=temp1
	    array[index+1]=temp2
      end
    end
  end
  puts array.inspect
end

def bubble_sort_by(array)
  no_pb = false
  while !no_pb
    no_pb = true
    array.each_with_index do |value,index|
      unless index == array.length-1
        if yield(array[index],array[index+1]) <= 0 
		  temp1=array[index]
		  temp2=array[index+1]
        else
		  temp1=array[index+1]
		  temp2=array[index]
		  no_pb = false
        end
  	    array[index]=temp1
	    array[index+1]=temp2
      end
    end
  end
  puts array.inspect
end

bubble_sort([4,3,78,2,0,2])
bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
