require './lib/twitter_config'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, TwitterConfig.key, TwitterConfig.secret
end
