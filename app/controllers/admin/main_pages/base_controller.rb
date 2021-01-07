class Admin::MainPages::BaseController < Admin::BaseController
  before_action :load_main_page

  private

  def load_main_page
    @main_page = MainPage.includes(:child_pages).from_param(params[:main_page_id])
  end

end
