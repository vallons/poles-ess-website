class EventsController < ApplicationController
  include SlugsAndRedirections

  def index
    @events = Schedule.includes(schedulable: :seo).future.oldest_first.distinct.page(params[:page]).per(8)
  end

  def past
    @events = Schedule.includes(schedulable: :seo).past.newest_first.distinct.page(params[:page]).per(8)
    render :index
  end

  private # =====================================================


end
