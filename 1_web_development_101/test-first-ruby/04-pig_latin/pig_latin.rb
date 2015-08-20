def translate(something)
	vowels = ['a', 'e', 'i', 'o', 'u']
	individuals = something.split.map do |word| 
		if word.include? ('qu')
			if word[0] == 'q' 
				word << 'qu'
				word = word[2..-1]
			elsif word[1] == 'q'
				word << word[0..2]
				word = word[3..-1]
			end
		elsif word.each_char.with_index do |item,index|
			if vowels.include? item
				index.times do |i|
					word << word[i]
					end
				word=word[index..-1]
				break
				end
			end
		end
		word << 'ay'
	end
	individuals.join(" ")
end