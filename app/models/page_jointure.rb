class PageJointure < ApplicationRecord

  # acts_as_list scope: [:main_page_id]

  # Associations ===============================================================
  belongs_to :basic_page
  belongs_to :main_page

  # Scopes ====================================================================

  scope :by_main_page, -> (val) {
    where(main_page_id: val)
  }

  # Instance methods ====================================================


end
