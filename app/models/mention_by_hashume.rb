class MentionByHashume
  include Curator::Model

  attr_accessor :hashume, :mention, :id

  def initialize(args)
    super(args.merge(id: "#{args[:hashume]}-#{args[:mention][:id]}"))
  end
end
