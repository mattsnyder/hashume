require './lib/null_object'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :hashtag

  # Helper method to parse current hashtag site being accessed (supports localhost too)
  def hashtag
    request.host.split('.')[-2] || request.host
  end

  protected
  def current_user=(value)
    session[:current_user] = value
  end

  def current_user
    session[:current_user]
  end

  # Nicely identify what is getting pushed to views
  def self.expose(*variable_names)
    variable_names.each do |variable_name|
      define_method((variable_name.to_s+"=").to_sym) do |value|
        @exposed ||= Hash.new
        @exposed[variable_name]= value
      end
      private (variable_name.to_s+"=").to_sym

      define_method(variable_name) do
        @exposed ||= Hash.new
        Maybe(@exposed[variable_name])
      end

      helper_method variable_name
    end
  end
end
