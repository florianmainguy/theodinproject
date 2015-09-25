# Recursive method to "merge sort" an array

def merge_sort(array)
  # base case
  if array.length == 1
    return array

  else
    a = merge_sort(array.slice!(0,array.length/2))
    b = merge_sort(array)

    # merge 2 lists in 1 sorted
    sorted_arr = []
    until a.empty? || b.empty?
      a[0] < b[0] ? sorted_arr << a.shift : sorted_arr << b.shift
    end
    sorted_arr += a += b
     
    sorted_arr
  end
end

example = [2, 5, 17, 3, 12, 9, 35, 30, 10]
puts merge_sort(example).inspect