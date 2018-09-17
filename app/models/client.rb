class Client < ApplicationModel
  has_paper_trail

  validates :name, :identifier, presence: true
  validates :identifier, :card, uniqueness: true

  has_many :movements

  def to_s
    name
  end
end
