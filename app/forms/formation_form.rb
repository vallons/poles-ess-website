# require "reform/form/dry"
require "reform/form/coercion"

class FormationForm < Reform::Form
  extend ActiveModel::ModelValidations
  # feature Reform::Form::Dry
  # feature Coercion

  model :formation
  property :created_at
  property :updated_at
  property :title#, type: Types::Nominal::String
  property :description, prepopulator: ->(options) { self.description = self.model.description }
  property :formation_category_id#, type: Types::Nominal::Integer
  property :address#, type: Types::Nominal::String
  property :zipcode#, type: Types::Nominal::String
  property :city#, type: Types::Nominal::String
  property :speaker
  property :cost
  property :tickets_count, prepopulator: ->(options) { self.tickets_count = Formation.default_tickets_count if self.tickets_count.blank? } #, type: Types::Nominal::Integer
  property :image

  property :seo,
    populate_if_empty: Seo,
    prepopulator: :prepopulate_seo! do
      property :id
      property :slug
      property :title
      property :description
  end

  collection :schedules,
    populator: :populate_schedules!,
    prepopulator: :prepopulate_schedules! do
    property :time_range
    property :start_at
    property :end_at
    property :date
    validates :date, :start_at, :end_at, presence: true
  end

  def prepopulate_schedules!(options)
    self.schedules = schedules
    while self.schedules.count < 2
      self.schedules << Schedule.new
    end
  end

  def populate_schedules!(fragment:, collection:, index:, **)
    return skip! if all_blank_schedule?(fragment)
    item = collection.find { |i| i.id.to_s == fragment['id'] }
    if fragment[:_destroy] == "1"
      collection.delete(item)
      return skip!
    end
    item ? item : collection.insert(index, Schedule.new)
  end

  def all_blank_schedule?(fragment)
    fragment[:date].blank? && fragment[:start_at].blank? && fragment[:end_at].blank?
  end


  # Validation -------------------------------------

  validates :title, :formation_category_id, :tickets_count, :schedules, presence: true
  copy_validations_from Seo

  # Prepopulate -------------------------------------

  def prepopulate_seo!(options)
    return seo if seo
    if (options[:id])
      self.seo =  Seo.find(options[:id])
    else
      self.seo = Seo.new
    end
  end


end