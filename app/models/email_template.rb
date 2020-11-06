# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  # Configurations =============================================================

  has_rich_text :body

  # Associations ===============================================================

  # Callbacks ==================================================================
  validates :mailer, :mail_name, presence: true

end
