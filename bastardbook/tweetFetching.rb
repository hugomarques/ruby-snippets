=begin
Fetch data from my twitter timeline. Based on Tweet fetching example available online the bastards handbook:
http://ruby.bastardsbook.com/chapters/intro_tweet_fetch/
Used gems:
1. open-uri - To download content.
2. oauth - For twitter authentication/authorization
For details how to use oauth with twitter see: https://dev.twitter.com/oauth/overview/single-user
=end
require 'open-uri'
require 'oauth'

CONSUMER_KEY,
CONSUMER_SECRET,
TOKEN_KEY,
TOKEN_SECRET = ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"], ENV["ACCESS_TOKEN"], ENV["ACCESS_TOKEN_SECRET"]

def prepare_access_token(oauth_token, oauth_token_secret)
  consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {:site => 'https://api.twitter.com', :scheme => :header })

  # now create the access token object from passed values
  token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

  return access_token
end

# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
access_token = prepare_access_token(TOKEN_KEY, TOKEN_SECRET)

puts 'Downloading...'
# use the access token as an agent to get the home timeline
response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=hugaomarques&count=100")
puts 'Done!'

my_local_tweets = open('my_local_tweets.json', 'w')
my_local_tweets.write(response.body)
my_local_tweets.close