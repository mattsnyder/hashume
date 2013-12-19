class Bird
  def initialize(user)
    @user = user
  end

  def choke_on(hashtag)
    results = petey.search "##{hashtag} from:#{@user.screen_name}"
    hashume = Hashume.new @user.screen_name, hashtag

    results.each do |t|
      tweet = Tweet.new(
                        screen_name: @user.screen_name,
                        id: t.id,
                        text: t.text,
                        hashtags: t.hashtags.map(&:text),
                        user_mentions: t.user_mentions.map(&:name),
                        created_at: t.created_at,
                        uri: t.uri.to_s
                        )

      TweetRepository.save tweet

      # Track tweets
      TweetByHashumeRepository.save TweetByHashume.new(hashume: hashume.to_s, tweet: TweetRepository.serialize(tweet))
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

        # Track mentions
        MentionByHashumeRepository.save MentionByHashume.new(hashume: hashume.to_s, mention: TweeterRepository.serialize(tweeter))
      end
    end
  end

  def petey
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = TwitterConfig.key
      config.consumer_secret     = TwitterConfig.secret
      config.access_token        = @user.oauth_token
      config.access_token_secret = @user.oauth_secret
    end
  end
end
