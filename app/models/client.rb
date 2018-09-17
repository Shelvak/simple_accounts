class Client < ApplicationModel
  has_paper_trail

  validates :name, :identifier, presence: true
  validates :identifier, :card, uniqueness: true

  def to_s
    name
  end
end
