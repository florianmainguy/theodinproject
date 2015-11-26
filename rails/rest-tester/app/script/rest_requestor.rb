require 'rest-client'
url = "http://0.0.0.0:8080/users"
puts RestClient.post(url, "")