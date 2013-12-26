class TweetByHashu
  include Curator::Model

  attr_accessor :tweet, :hashu, :id

  def initialize(args)
    super(args.merge(id: "#{args[:hashu]}-#{args[:tweet][:id]}"))
  end

end
