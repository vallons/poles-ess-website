class EventsController < ApplicationController
  include SlugsAndRedirections

  def index
    @future_events = Schedule.includes(schedulable: :seo).future.oldest_first.compact
    @past_events = Schedule.includes(schedulable: :seo).past.newest_first.compact
  end

  private # =====================================================


end
