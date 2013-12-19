class HomeController < ApplicationController
  expose :tweets, :screen_name, :mentions
  before_action :update_tweets, only: :dashboard

  helper_method :profile_pic_url

  def profile_pic_url(name)
    self.mentions.detect{|m| m['name'] == name}['profile_image_mini']
  end

  def index; end

  def dashboard
    self.screen_name = current_user.screen_name
    self.tweets = TweetByHashumeRepository.find_by_hashume(hashume.to_s).map(&:tweet).sort{|x,y| y[:created_at] <=> x[:created_at]}
    self.mentions = MentionByHashumeRepository.find_by_hashume(hashume.to_s).map(&:mention)
  end

  def hashume
    @hashume ||= Hashume.new current_user.screen_name, hashtag
  end

  def update_tweets
    tweets = twitter.search "##{hashtag} from:#{current_user.screen_name}"
    debug %(Located #{tweets.count} tweets)
    tweets.each do |t|
      debug "Match: #{t.inspect}"
      tweet = Tweet.new(
                        screen_name: current_user.screen_name,
                        id: t.id,
                        text: t.text,
                        hashtags: t.hashtags.map(&:text),
                        user_mentions: t.user_mentions.map(&:name),
                        created_at: t.created_at,
                        uri: t.uri.to_s
                        )
      debug %(New tweet #{tweet.inspect})
      TweetRepository.save tweet
      TweetByHashumeRepository.save TweetByHashume.new(hashume: hashume.to_s, tweet: TweetRepository.serialize(tweet))
      t.user_mentions.each do |u|
        mentioned = twitter.user(u.id)
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

        debug %(New tweeter #{tweeter.inspect})
        TweeterRepository.save tweeter
        MentionByHashumeRepository.save MentionByHashume.new(hashume: hashume.to_s, mention: TweeterRepository.serialize(tweeter))
      end
    end
  end
  protected :update_tweets

end
