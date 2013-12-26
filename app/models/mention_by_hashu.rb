class MentionByHashu
  include Curator::Model

  attr_accessor :hashu, :mention, :id

  def initialize(args)
    super(args.merge(id: "#{args[:hashu]}-#{args[:mention][:id]}"))
  end
end
