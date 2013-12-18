class Tweeter
  include Curator::Model

  attr_accessor :description, :followers_count, :friends_count, :name,
                :statuses_count, :screen_name, :id, :profile_image_normal,
                :profile_image_mini, :oauth_token, :oauth_secret
end
