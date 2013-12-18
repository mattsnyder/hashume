class TweetByHashumeRepository
  include Curator::Repository

  indexed_fields :hashume
end
