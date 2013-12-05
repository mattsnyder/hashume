class HomeController < ApplicationController
  expose :tweets, :nickname

  def index; end

  # Not saving to DB at moment. Will be using Riak awesomness for that, but
  # want to identify twitter api needs first.
  def dashboard
    self.nickname = current_user[:nickname]
    self.tweets = twitter.user_timeline(self.nickname)
  end

  private

  # Will get extracted to a service class soon enough
  def twitter
    Rails.logger.debug "Using the twitter client"
    Twitter::REST::Client.new do |config|
      config.consumer_key        = TwitterConfig.key
      config.consumer_secret     = TwitterConfig.secret
      config.access_token        = self.current_user[:oauth_token]
      config.access_token_secret = self.current_user[:oauth_secret]
    end
  end
end
