class TweetByHashume
  include Curator::Model

  attr_accessor :tweet, :hashume, :id

  def initialize(args)
    super(args.merge(id: "#{args[:hashume]}-#{args[:tweet][:id]}"))
  end

end
