class Formation < ApplicationRecord

  DEFAULT_TICKET_COUNT = 12

  include Seoable

  has_rich_text :description
  has_one_attached :image

  belongs_to :formation_category

  has_many :schedules, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable
  has_one :first_schedule, -> {order(:time_range)}, as: :schedulable, class_name: 'Schedule'
  accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true


  has_many :subscriptions, inverse_of: :formation, dependent: :restrict_with_exception
  has_many :participants, through: :subscriptions

  # Validations ================================================================

  validates :title, :schedules,
            presence: true

  # Scopes ====================================================================

  scope :by_formation_category, -> (val) {
    where(formation_category_id: val)
  }

  scope :sort_by_start_date, -> {
   joins(:schedules).merge(Schedule.sort_by_start_date)
  }

  scope :sort_by_future, -> {
   eager_load(:first_schedule).merge(Schedule.future)
  }

  scope :sort_by_formation_category, -> {
    group_by(&:formation_category).sort_by{ |cat, array| cat.position }
  }

  # Instance methods ====================================================

  def start_date
    schedules.first.time_range.first
  end

  def remaining_tickets
    tickets_count - participants.participation_confirmed.count
  end

  def is_full?
    remaining_tickets <= 0
  end

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation_category,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
      self.order(created_at: :desc)
  end

  def self.default_tickets_count
    Formation::DEFAULT_TICKET_COUNT
  end

  def self.default
    formation = self.new(tickets_count: self.default_tickets_count)
    formation.build_seo
    formation.schedules.new
    formation
  end

end
