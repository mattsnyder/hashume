require './lib/null_object'
require './lib/hashu_config'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :hashtag

  # Helper method to parse current hashtag site being accessed (supports localhost too)
  def hashtag
    if HashuConfig.use_domain == true
      request.host.split('.')[-2] || request.host
    else
      "hashu"
    end
  end

  protected
  def current_user=(tweeter)
    session[:current_user] = tweeter
  end

  def current_user
    session[:current_user]
  end

  def debug(message)
    Rails.logger.debug "="*20
    Rails.logger.debug message
    Rails.logger.debug "="*20
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
