class Hashu
  def initialize(screen_name, hashtag)
    @screen_name = screen_name
    @hashtag = hashtag
  end

  def to_s
    %(#{@screen_name}:#{@hashtag})
  end
end
