Curator.configure(:mongo) do |config|
  config.environment = Rails.env
  config.migrations_path = Rails.root.join("db/migrate")
  config.database = "hashu"

  unless ENV['MONGO_URI']
    config.mongo_config_file = Rails.root.join("config/mongo.yml")
  end

  #   db = URI.parse(ENV['MONGOHQ_URL'])
  #   db_name = db.path.gsub(/^\//, '')
  #   connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  #   connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  #   config.client = connection

end
