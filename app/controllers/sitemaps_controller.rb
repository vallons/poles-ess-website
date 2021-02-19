class SitemapsController < ApplicationController
  respond_to :html, :xml

  def show
    # get_seo_for_static_page("sitemap")
    @site_map = Sitemap.get_all_pages

    respond_with(@site_map) do |format|
      format.html do
        @breadcrumbs = []
        @breadcrumbs << [ "Accueil", root_path ]
        @breadcrumbs << [ "Plan du site", sitemap_path ]
      end
      format.xml { render layout: false }
    end
  end
end
