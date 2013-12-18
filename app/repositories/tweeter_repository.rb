class TweeterRepository
  include Curator::Repository

  indexed_fields :screen_name, :uid
end
