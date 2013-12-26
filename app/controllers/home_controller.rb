require './lib/bird'

class HomeController < ApplicationController
  expose :tweets, :screen_name, :mentions, :last_update
  before_action :update_tweets, only: :dashboard

  helper_method :profile_pic_url
  def profile_pic_url(name)
    self.mentions.detect{|m| m['name'] == name}['profile_image_mini']
  end

  def index
    redirect_to :dashboard if current_user
  end

  def dashboard
    self.screen_name = current_user.screen_name
    self.tweets = TweetByHashuRepository.find_by_hashu(hashu.to_s).map(&:tweet).sort{|x,y| y[:created_at] <=> x[:created_at]}
    self.mentions = MentionByHashuRepository.find_by_hashu(hashu.to_s).map(&:mention)
  end

  def hashu
    @hashu ||= Hashu.new current_user.screen_name, hashtag
  end

  def update_tweets
    self.last_update = Bird.new(current_user).choke_on(hashtag)
  end
  protected :update_tweets

end
