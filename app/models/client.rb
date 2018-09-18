class Client < ApplicationModel
  has_paper_trail

  validates :name, :identifier, presence: true
  validates :identifier, :card, uniqueness: true

  has_many :movements

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

end
