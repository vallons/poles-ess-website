# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, _instance_tag|
  element = Nokogiri::HTML::DocumentFragment.parse(html_tag).children.first
  element.set_attribute "class", ["is-invalid", element.attribute("class")].compact.join(' ')

  element.to_html.html_safe
end
