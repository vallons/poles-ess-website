# frozen_string_literal: true

module ThemeHelper

  def theme_options(themes = Theme.all)
    themes.order(title: :asc).map do |theme|
      [theme.title, theme.id]
    end
  end

end