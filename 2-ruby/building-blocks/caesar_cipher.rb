def caesar_cipher(string, shift_factor)
	cipher = Array.new
	alphabet_down = ('a'..'z').to_a
	alphabet_up = ('A'..'Z').to_a
	string.split("").each do |letter|
		if alphabet_down.include?(letter) 
			cipher << alphabet_down[(alphabet_down.index(letter) + shift_factor) % 26]
		elsif alphabet_up.include?(letter)
			cipher << alphabet_up[(alphabet_up.index(letter) + shift_factor) % 26]
		else
			cipher << letter
		end
	end
	cipher.join
end

puts caesar_cipher("Hello everyone! Hope you enjoy my program", 2)
puts caesar_cipher("Hello everyone! Hope you enjoy my program", 27)
puts caesar_cipher("Hello everyone! Hope you enjoy my program", -5)
