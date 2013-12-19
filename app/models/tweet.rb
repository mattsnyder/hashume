class Tweet
  include Curator::Model

  attr_accessor :id, :hashtags, :text, :user_mentions, :uri,
                :source, :screen_name, :created_at

end
