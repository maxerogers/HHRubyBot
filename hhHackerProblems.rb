require 'koala'
require 'date'

oauth_access_token = "CAACEdEose0cBAHw0ABJ9wba9w1ZCS00pdrFqNdChzWJkDkr3QLdWfJxQ3tAtRpMgPNQ6P2pXZBr2BjRun2PRqlA6HWuUPIPj1Rjn8Da6k2PKLWbb2jlCpUXKNI5vqXoWa4vbZCvEnpGysJfsDSBClwKXNBlfZCUDqfTtqMMbf3AC9U7prwiSCaDJ4Yq721C6OWnd6dWCTzsa6GZBR2yxGaGR0sCeIZBf0ZD"
@graph = Koala::Facebook::API.new(oauth_access_token)
hacker_problems_feed = @graph.get_object("291381824396182/feed")
puts "Be Patient....doing all the graph requests"
days = {}
while hacker_problems_feed.paging do

  hacker_problems_feed.each_with_index do |post,index|
    day = Date.parse(post["created_time"])
    day_string = day.strftime("%B %d, %Y")
    days[day_string] ||= 0
    days[day_string] += 1
  end

  next_page = hacker_problems_feed.paging["next"].split("https://graph.facebook.com/v2.0/")[1]
  hacker_problems_feed = @graph.get_object(next_page)

end
days = days.sort.to_h
votes = []
days.each do |key,value|
  puts "#{key}: #{value}"
  votes.push value
end
puts "All Done"
votes = votes.sort
avg = 0
votes.each do |vote|
  avg += vote
end
avg /= votes.size
puts "Average: #{avg}"
puts "Median: #{votes[votes.size/2]}"
puts votes
