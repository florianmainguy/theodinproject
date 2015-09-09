# Hangman
=begin
déféinir nom a trouver

boucle
  demander lettre
  checker lettre
  display
=end

def select_word_to_guess
  file = File.readlines "5desk.txt"
  file[rand(0..file.length)]
end

def select_letter
  puts "Please select a letter"
end

word = select_word_to_guess

puts "Welcome to Hangman!"

win = false
until win
  select_letter
end