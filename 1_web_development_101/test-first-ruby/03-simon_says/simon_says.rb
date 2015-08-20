def echo(something)
	"#{something}"
end

def shout(something)
	"#{something.upcase}"
end

def repeat(something,nb=2)
	string=''
	nb.times do |i|
		string.concat(something)
		if (i < nb-1)
			string << ' '
		end
	end
	"#{string}"
end

def start_of_word(something,nb)
	string = ''
	something.each_char.with_index do |item,index|
		string << item
		if (index == nb-1)
			break
		end
	end
	"#{string}"
end

def first_word(something)
	string = ''
	something.each_char do |item|
		if (item == ' ')
			break
		end
		string << item
	end
	string
end

def titleize(something)
	words = something.split.map do |word|
		if %w(the and over).include?(word)
			word
		else
			word.capitalize
		end
	end
	words.first.capitalize!
	words.join(' ')
end
