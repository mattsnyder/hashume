class TwitterConfig
  def self.key
    ENV['TWITTER_KEY']
  end
  def self.secret
    ENV['TWITTER_SECRET']
  end
end
