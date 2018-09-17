class Movement < ApplicationModel
  has_paper_trail

  enum kind: %i[credit debit]

  belongs_to :client
  belongs_to :user
end
