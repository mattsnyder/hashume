Curator.configure(:mongo) do |config|
  config.database = "hashume"
  config.environment = Rails.env
  config.migrations_path = Rails.root.join("db/migrate")
  config.mongo_config_file = Rails.root.join("config/mongo.yml")
end
