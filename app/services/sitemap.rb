module Sitemap

  def self.get_all_pages

    hash = []

    # Page d'accueil
    h = {loc: Rails.application.routes.url_helpers.root_url, priority: 1, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Accueil", href: true, elements: []}
    hash << { home: h }

    # MainPages + Child Pages

    MainPage.no_parent.enabled.order(:position).each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.main_page_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}

      page.child_pages.enabled.order(:position).each do |child_page|
        child_page_elt = {loc: Rails.application.routes.url_helpers.main_page_url(child_page),
        priority: 0.7, lastmod: Time.now.strftime("%Y-%m-%d"), title: child_page.title, href: true, elements: []}
        page_elt[:elements] << { child_page: child_page_elt }
      end
      hash << { page: page_elt }
    end

    # Thème

    theme_title = {loc: "#", priority: 0.5, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Thèmes", href: false, elements: []}

    Theme.enabled.order(:position).each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.theme_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}
      theme_title[:elements] << { theme: page_elt }
    end
    hash << { theme_title: theme_title }

    # Profils

    profile_title = {loc: "#", priority: 0.5, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Profils", href: false, elements: []}

    Profile.enabled.order(:position).each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.profile_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}
      profile_title[:elements] << { profile: page_elt }
    end
    hash << { profile_title: profile_title }

    # Formations

    formation_title = {loc: Rails.application.routes.url_helpers.formations_url, priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Formations", href: true, elements: []}

    Formation.enabled.sort_by_start_date.each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.formation_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}
      formation_title[:elements] << { formation: page_elt }
    end
    hash << { formation_title: formation_title }

    # Actions

    activity_title = {loc: Rails.application.routes.url_helpers.activities_url, priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Actions", href: true, elements: []}

    Activity.enabled.order(title: :asc).each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.activity_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}
      activity_title[:elements] << { activity: page_elt }
    end
    hash << { activity_title: activity_title }

    # Actu

    post_title = {loc: Rails.application.routes.url_helpers.posts_url, priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"),
      title: "Actualités", href: true, elements: []}

    Activity.enabled.order(title: :asc).each do |page|
      page_elt = {loc: Rails.application.routes.url_helpers.post_url(page),
      priority: 0.9, lastmod: Time.now.strftime("%Y-%m-%d"), title: page.title, href: true, elements: []}
      post_title[:elements] << { post: page_elt }
    end
    hash << { post_title: post_title }

    # Autres


    hash

  end
end
