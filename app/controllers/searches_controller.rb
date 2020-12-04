class SearchesController < ApplicationController
  def show
    @results = PgSearch.multisearch(search_params[:query]).with_pg_search_highlight
  end

  private

  def search_params
    params.permit(:query)
  end

end