# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @agenda_items = Schedule.includes(schedulable: :seo).future.sort_by_start_date.limit(4)
    @posts = Post.enabled.includes(:seo, :themes, :post_category)
      .published.order(published_at: :desc).limit(2)
    @highlighted_activities = Activity.highlighted.order(Arel.sql('RANDOM()'))
  end

end
