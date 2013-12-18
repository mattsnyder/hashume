class TweetRepository
  include Curator::Repository

  indexed_fields :id, :screen_name
end
