require 'singleton'
require 'byebug'
require 'twitter'
require 'httparty'

class TwitterClient
  SERVER_API='http://localhost:3000'

  attr_accessor :client
  include Singleton

  def initialize
    @unsended_tweets = []
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = 'bjhB5ny617HR9XUJKVaRPZQfC'
      config.consumer_secret     = 'KeBQrBJ2P6hpi1YwJE28BUckUbHwQIieE20jnV1fZ5bfji35fm'
      config.access_token        = '701414022906847233-KA4LJmO2FHPMxeiGTo0taWckNfPBsPl'
      config.access_token_secret = 'h9XW7Zpido6DtPU9Ba4Vzl5iIuydAi7O2za7TTHHjpWUw'
    end
  end

  def track_tweets(keys)
    @client.filter(track: keys) do |tweet|
      begin
        send_tweets(keys, tweet) if tweet.is_a?(Twitter::Tweet)
        send_tweets(keys, @unsended_tweets) unless @unsended_tweets.empty?
      rescue Errno::ECONNREFUSED => e
        @unsended_tweets << tweet
        puts e.message
      end
    end
  end

  private
    def send_tweets(keys, tweets)
      @result = HTTParty.post("#{SERVER_API}/tweets",
                            :body => tweets_to_json(keys, tweets),
                            :headers => { 'Content-Type' => 'application/json' } )

      @unsended_tweets = [] if tweets.is_a? Array
    end

    def tweets_to_json(keys, tweets)
      json_tweets = []
      if tweets.is_a? Array
        tweets.each do |tweet|
          json_tweets << tweet_to_json(keys, tweet)
        end
      else
        json_tweets << tweet_to_json(keys, tweets)
      end

      {tweets: json_tweets}.to_json
    end

    def tweet_to_json(keys, tweet)
      {
        content: tweet.text,
        date: tweet.created_at,
        username: tweet.user.screen_name,
        key: keys
      }
    end
end