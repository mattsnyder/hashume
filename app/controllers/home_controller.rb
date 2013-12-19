require './lib/bird'

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
   Bird.new(current_user).choke_on(hashtag)
  end
  protected :update_tweets

end
