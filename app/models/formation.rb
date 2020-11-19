class Formation < ApplicationRecord

  DEFAULT_TICKET_COUNT = 12

  include Seoable

  has_rich_text :description
  has_one_attached :image

  belongs_to :formation_category

  has_many :schedules, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable, dependent: :destroy
  has_one :first_schedule, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable, class_name: 'Schedule'
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
    # inner_query = self.joins(:schedules)
    # .select("DISTINCT ON (formations.id) formations.*, schedules.time_range as date") #This selects all the unique purchased formations.

    # result = self.from("(#{inner_query.to_sql}) as unique_schedules")
    #   .select("unique_schedules.*").order("unique_schedules.date DESC")
    # result





    # left_outer_joins(:schedules)
    # .where(id: distinct.select(:id))
    # .distinct
    # .order('schedules.time_range')
    # .select('DISTINCT formations.id, formations.title, formations.formation_category_id, formations.tickets_count, formations.created_at, schedules.schedulable_type, schedules.schedulable_id, schedules.time_range')



    # includes(:schedules).order('schedules.time_range')
    # SELECT "formations"."id", "formations"."title", "formations"."description", "formations"."formation_category_id", "formations"."address", "formations"."zipcode", "formations"."city", "formations"."speaker", "formations"."tickets_count", "formations"."cost", 
    # "schedules"."id", "schedules"."time_range", "schedules"."schedulable_type", "schedules"."schedulable_id" 
    # FROM "formations" LEFT OUTER JOIN "schedules" ON "schedules"."schedulable_type" = 'Formation' AND "schedules"."schedulable_id" = "formations"."id" 
    # WHERE "formations"."id" IN ($2, $3, $4, $5) ORDER BY schedules.time_range
    # SELECT "formations"."id" AS t0_r0, "formations"."title" AS t0_r1, "formations"."description" AS t0_r2, "formations"."formation_category_id" AS t0_r3, "formations"."address" AS t0_r4, "formations"."zipcode" AS t0_r5, "formations"."city" AS t0_r6, "formations"."speaker" AS t0_r7, "formations"."tickets_count" AS t0_r8, "formations"."cost" AS t0_r9, "formations"."created_at" AS t0_r10, "formations"."updated_at" AS t0_r11, "schedules"."id" AS t1_r0, "schedules"."time_range" AS t1_r1, "schedules"."schedulable_type" AS t1_r2, "schedules"."schedulable_id" AS t1_r3, "schedules"."created_at" AS t1_r4, "schedules"."updated_at" AS t1_r5 FROM "formations" LEFT OUTER JOIN "schedules" ON "schedules"."schedulable_type" = $1 AND "schedules"."schedulable_id" = "formations"."id" WHERE "formations"."id" IN ($2, $3, $4, $5) ORDER BY schedules.time_range
    # preload(:schedules).order('schedules.time_range')
  #  eager_load(:first_schedule).merge(Schedule.sort_by_start_date)
  #  left_outer_joins(:first_schedule).merge(Schedule.sort_by_start_date)
    # left_outer_joins(:schedules)
    # .select('formations.*, schedules.time_range')
    # .group("formations.id,  schedules.time_range")
    # .merge(Schedule.sort_by_start_date)
    # .distinct
  #  joins(:first_schedule).select('distinct formations.*, first_schedule.range').merge(Schedule.sort_by_start_date)
  # joins(:schedules)
  #   .select('DISTINCT formations.*, schedules.time_range')
  #   .order('schedules.time_range')

}

  scope :sort_by_future, -> {
   left_outer_joins(:first_schedule).merge(Schedule.future)
  }

  scope :sort_by_formation_category, -> {
    sort_by_start_date.group_by(&:formation_category).sort_by{ |cat, array| cat.position }
  }

  scope :in_most_recent_year, -> {
    eager_load(:first_schedule).merge(Schedule.in_most_recent_year)
  }

  scope :by_year, -> (year) {
    eager_load(:first_schedule).merge(Schedule.by_year(year)).references(:schedules)
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

  def future?
    schedules.first.future?
  end

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation_category,
      :by_year,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
      self.sort_by_start_date
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
