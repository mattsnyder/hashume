class SessionsController < ApplicationController
  def create
    tweeter = build_tweeter auth_hash
    TweeterRepository.save(tweeter)
    self.current_user = tweeter

    redirect_to dashboard_path
  end

  private
  def build_tweeter(stuff)
    Tweeter.new(
                id: stuff['uid'],
                screen_name: stuff['info']['nickname'],
                name: stuff['info']['name'],
                description: stuff['info']['description'],
                oauth_token: stuff['extra']['access_token'].token,
                oauth_secret: stuff['extra']['access_token'].secret
                )
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
