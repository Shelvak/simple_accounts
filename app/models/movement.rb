class Movement < ApplicationModel
  has_paper_trail

  enum kind: %i[credit debit]

  belongs_to :client, optional: false
  belongs_to :user, optional: false
end
