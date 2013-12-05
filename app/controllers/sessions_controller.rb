class SessionsController < ApplicationController
  def create
    self.current_user = save_important_stuff(auth_hash)
    redirect_to dashboard_path
  end

  private
  # Will get wrapped in a model at some point soon
  def save_important_stuff(stuff)
    {
      provider: stuff['provider'],
      name: stuff['info']['name'],
      nickname: stuff['info']['nickname'],
      avatar: stuff['info']['image'],
      uid: stuff['uid'],
      oauth_token: stuff['extra']['access_token'].token,
      oauth_secret: stuff['extra']['access_token'].secret
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
