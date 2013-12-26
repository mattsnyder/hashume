class Bird
  def initialize(user)
    @user = user
  end

  def updated_recently?(hashu)
    update = BirdUpdateRepository.find_by_id(hashu.to_s)
    return false unless update

    update.last_update > 2.minutes.ago
  end

  def choke_on(hashtag)
    hashu = Hashu.new @user.screen_name, hashtag
    return if updated_recently?(hashu)
    results = petey.search "##{hashtag} from:#{@user.screen_name}"
    results.each do |t|
      # Store the tweet
      tweet = Tweet.new(
                        screen_name: @user.screen_name,
                        id: t.id,
                        text: t.text,
                        hashtags: t.hashtags.map(&:text),
                        user_mentions: t.user_mentions.map(&:name),
                        created_at: t.created_at,
                        uri: t.uri.to_s,
                        coordinates: Maybe(t.geo.coordinates) {[]},
                        source:t.source,
                        media:build_media_object(t.media)
                        )
      TweetRepository.save tweet

      # Store tweets by tweeter and hash (hashu)
      TweetByHashuRepository.save TweetByHashu.new(hashu: hashu.to_s, tweet: TweetRepository.serialize(tweet))
      t.user_mentions.each do |u|
        mentioned = petey.user(u.id)
        tweeter = Tweeter.new(
                              id: mentioned.id,
                              screen_name: mentioned.screen_name,
                              name: mentioned.name,
                              description: mentioned.description,
                              followers_count: mentioned.followers_count,
                              friends_count: mentioned.friends_count,
                              statuses_count: mentioned.statuses_count,
                              profile_image_normal: mentioned.profile_image_uri(:bigger).to_s,
                              profile_image_mini: mentioned.profile_image_uri(:normal).to_s )
        TweeterRepository.save tweeter

        # Store mentions by tweeter and hash (hashu)
        MentionByHashuRepository.save MentionByHashu.new(hashu: hashu.to_s, mention: TweeterRepository.serialize(tweeter))
      end
    end

    BirdUpdateRepository.save BirdUpdate.new(id: hashu.to_s, last_update: Time.now)
  end

  def petey
    Rails.logger.info "Accessing the bird"

    @pretty_bird ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = TwitterConfig.key
      config.consumer_secret     = TwitterConfig.secret
      config.access_token        = @user.oauth_token
      config.access_token_secret = @user.oauth_secret
    end
  end

  def build_media_object(media_array)
    new_media_hash = Hash.new
    media_array.each do |value|
      new_media_hash[:media_url] = value[:media_url].to_s
      new_media_hash[:url] = value[:url].to_s
    end
    new_media_hash
  end
end
