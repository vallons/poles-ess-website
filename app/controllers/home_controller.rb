# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @agenda_items = Schedule.includes(schedulable: :seo).future.sort_by_start_date.map{ |s| s.schedulable }.compact.uniq
    @posts = Post.enabled.includes(:seo, :themes, :post_category)
      .published.order(published_at: :desc).limit(2)
  end

end
