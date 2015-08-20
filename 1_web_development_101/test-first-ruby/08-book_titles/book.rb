class Book
	def title=(name)
		@title = name
	end

	def title
		conjunctions = ['and', 'or']
		prepositions = ['in', 'the', 'of', 'a', 'an']
		words=@title.split.map {|word| 
			if (conjunctions + prepositions).include? word
				word
			else
				word.capitalize
			end
		}
		words[0]=words[0].capitalize
		words.join(' ')
	end
end
