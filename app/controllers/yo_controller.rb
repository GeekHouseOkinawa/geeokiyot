class YoController < ApplicationController
  def index
    yo_api = ENV['YO_API_KEY']
    @username = params['username']
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    yo = Hey::Yo.new(api_token: yo_api)
    begin
      yo.user @username
    rescue
      client.update("#{@username} のYoがお盛んです")
    else
      client.update ("Yo via #{@username}")
    end
  end
end
