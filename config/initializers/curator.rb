Curator.configure(:mongo) do |config|
  config.database = "hashume"
  config.environment = Rails.env
  config.migrations_path = Rails.root.join("db/migrate")

  if Rails.env == 'production'
    db = URI.parse(ENV['MONGOHQ_URL'])
    db_name = db.path.gsub(/^\//, '')
    connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    config.client = connection
  else
    config.client = Mongo::Connection.new
  end

end
