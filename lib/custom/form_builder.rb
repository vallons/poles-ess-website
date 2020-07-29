# frozen_string_literal: true

module Custom
  module FormBuilder

    # Affiche les erreurs du formulaire
    # Paramètres possibles :
    # - show_title: boolean (true par défaut)
    # - only: <nested_attributes>
    # - except: <nested_attributes>
    def form_errors(params = {})
      return unless (errors = object.errors).any?

      @template.content_tag :div, class: "alert alert-danger" do
        content = []
        content << @template.content_tag(:strong, I18n.t(:form_errors))
        content << @template.content_tag(:ul) do
          messages = errors.full_messages

          return "" if messages.empty?

          messages.map { |msg| @template.content_tag(:li, msg) }.join.html_safe
        end

        content.join.html_safe
      end
    end

  end
end

ActionView::Helpers::FormBuilder.include Custom::FormBuilder
