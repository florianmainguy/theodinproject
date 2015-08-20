def substrings(phrase,dictionary)
  result = Hash.new(0)
  words = phrase.downcase
  dictionary.each do |substring|
    match = words.scan(substring).length 
    result[substring] = match unless match < 1
  end
  puts result
end
   
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"] 
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)