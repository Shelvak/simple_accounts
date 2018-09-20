class Client < ApplicationModel
  include PgSearch

  has_paper_trail

  pg_search_scope :search_full_text, against: [:name, :identifier]
  pg_search_scope :unicode_search, against: [:name, :identifier],
    ignoring: :accents,
    using: {
      tsearch: { prefix: false },
      trigram: { threshold: 0.1 }
    }

  validates :name, :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :card, uniqueness: true, allow_blank: true, allow_nil: true

  has_many :movements, dependent: :destroy

  before_save :strip_fields

  def to_s
    name
  end
  alias_method :label, :to_s

  def as_json(options = nil)
    default_options = {
      only: [:id, :identifier],
      methods: [:label, :amount]
    }

    super(default_options.merge(options || {}))
  end

  def amount
    (movements.credit.sum(:amount) || 0.0) -
      (movements.debit.sum(:amount) || 0.0)
  end

  def strip_fields
    self.name = self.name.strip if name
    self.identifier = self.identifier.strip if identifier
    self.card = self.card.strip if card
  end
end
