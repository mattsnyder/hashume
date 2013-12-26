class MentionByHashuRepository
  include Curator::Repository

  indexed_fields :hashu
end
