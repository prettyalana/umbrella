require "http"
require "json"
require "ascii_charts"

#pp "Alana"

pp "Where are you?"

#user_location = gets.chomp.gsub(" ", "%20")

user_location = "Chicago"

pp user_location

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY") #Could I use string interpolation here?


user_response = HTTP.get(gmaps_url)

raw_response = user_response.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_results = results[0]

geo = first_results.fetch("geometry")

locator = geo.fetch("location")

pp latitude = locator.fetch("lat")
pp longitude = locator.fetch("lng")







weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

weather_url = "https://api.pirateweather.net/forecast/#{weather_api_key}/#{latitude},#{longitude}"

much_needed_info = HTTP.get(weather_url)

# important_info = much_needed_info.to_s



response_search = JSON.parse(much_needed_info)
  
location_weather = response_search.fetch("currently")

pp current_temp = location_weather.fetch("temperature")

hourly_temp = response_search.fetch("hourly")

pp summary = hourly_temp.fetch("summary")

precip_data = hourly_temp.fetch("data")

precip_prob = precip_data[1]

precip_predict = precip_prob.fetch("precipProbability")

precip_percent = (precip_predict * 100).round

puts "#{precip_percent}%"

#What method would I use to turn this decimal number into a percentage?

# How do I get the precipitation probablility for the next 12 hours?

if precip_predict > 0.10
  puts "You might want to carry an umbrella!"
else
  puts "You probably won't need an umbrella today."
end






# # I've already created a string variable above: pirate_weather_api_key
# # It contains sensitive credentials that hackers would love to steal so it is hidden for security reasons.

# require "http"

# pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# # Assemble the full URL string by adding the first part, the API token, and the last part together
# pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

# # Place a GET request to the URL
# raw_response = HTTP.get(pirate_weather_url)

# require "json"

# parsed_response = JSON.parse(raw_response)

# currently_hash = parsed_response.fetch("currently")

# current_temp = currently_hash.fetch("temperature")

# puts "The current temperature is " + current_temp.to_s + "."
