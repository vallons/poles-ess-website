# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @agenda_items = Schedule.future.map{ |s| s.schedulable }.compact.uniq
    @posts = Post.published.order(published_at: :desc).limit(2)
  end

end
