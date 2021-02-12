class EventsController < ApplicationController
  include SlugsAndRedirections

  def index
    @events = Schedule.includes(schedulable: :seo).future.oldest_first.compact
  end

  def past
    @events = Schedule.includes(schedulable: :seo).past.newest_first.compact
    render :index
  end

  private # =====================================================


end
