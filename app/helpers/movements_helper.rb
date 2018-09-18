module MovementsHelper
  def movement_kinds_translation(kind)
    t(kind, scope: [:view, :movements, :kinds])
  end

  def movement_kind_field(form)
    collection = Movement.kinds.map do |kind_name, _kind_value|
      [movement_kinds_translation(kind_name), kind_name]
    end

    form.input :kind, as: :select,
      collection: collection,
      prompt: false,
      include_blank: false
  end
end
