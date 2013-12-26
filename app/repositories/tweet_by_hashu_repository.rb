class TweetByHashuRepository
  include Curator::Repository

  indexed_fields :hashu
end
