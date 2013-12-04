class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :hashtag

  def hashtag
    request.host.split('.')[-2] || request.host
  end
end
