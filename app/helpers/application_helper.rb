module ApplicationHelper
  def hashtag_sniffer(original_tweet)
    original_tweet.gsub(/\B#(\w+)/i, content_tag(:span, "\\1")).html_safe
  end
end
