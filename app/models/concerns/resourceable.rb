# frozen_string_literal: true

module Resourceable
  extend ActiveSupport::Concern

  included do
    has_many :resources, -> { order(:position) }, as: :resourceable, inverse_of: :resourceable, dependent: :destroy
    accepts_nested_attributes_for :resources, reject_if: :is_empty_resource, allow_destroy: true
  end

  def is_empty_resource(attributes)
    attributes['title'].blank? && (document_without_document(attributes) || link_without_link(attributes))
  end

  def document_without_document(attributes)
    attributes['category'] == 'document' && attributes['document'].blank?
  end

  def link_without_link(attributes)
    attributes['category'] == 'link' && attributes['link'].blank?
  end

end
