class EventsController < ApplicationController
  include SlugsAndRedirections

  def index
    @future_events = @agenda_items = Schedule.includes(schedulable: :seo).future.oldest_first.map{ |s| s.schedulable }.compact.uniq
    @past_events = @agenda_items = Schedule.includes(schedulable: :seo).past.newest_first.map{ |s| s.schedulable }.compact.uniq

  end

  private # =====================================================


end
