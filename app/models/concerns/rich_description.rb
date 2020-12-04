# frozen_string_literal: true
module RichDescription
  extend ActiveSupport::Concern

  included do
    has_rich_text :description

    before_save :update_search_description
  end

  private

  def update_search_description
    self.search_description = self.description.to_plain_text
  end
end
