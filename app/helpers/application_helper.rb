module ApplicationHelper
  def title
    [t('app_name'), @title].compact.join(' | ')
  end

  def show_menu_link(options = {})
    name = t("menu.#{options[:name]}")
    classes = []

    classes << 'active' if [*options[:controllers]].include?(controller_name)

    content_tag(
      :li, link_to(name, options[:path]),
      class: (classes.empty? ? nil : classes.join(' '))
    )
  end

  def show_button_dropdown(main_action, extra_actions = [], options = {})
    if extra_actions.blank?
      main_action
    else
      out = ''.html_safe

      out << render(
        partial: 'shared/button_dropdown', locals: {
          main_action: main_action, extra_actions: extra_actions
        }
      )
    end
  end

  def show_filtered_by(klass:, fields:)
    return if fields.blank?

    fields_in_list = content_tag(:ul) do
      fields.map do |field|
        link = [klass.human_attribute_name(field), @filters[field].to_s].join(': ')
        link += '   '
        link += link_to(remove_icon.html_safe, query_params.except(field))

        content_tag(
          :li,
          link.html_safe
        ).html_safe
      end.join.html_safe
    end.html_safe

    t(:filtered_by, scope: [:view, :generic], field: fields_in_list).html_safe
  end

  def query_params
    request.query_parameters
  end
end
