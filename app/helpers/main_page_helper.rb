# frozen_string_literal: true

module MainPageHelper
  def parent_page_options(parent_pages = MainPage.no_parent)
    parent_pages.order(position: :asc).map do |parent_page|
      [parent_page.title, parent_page.id]
    end
  end

  def edit_admin_page_path(page)
    if page.special_page?
      begin
        polymorphic_path([:admin, page.key.classify.constantize])
      rescue
        nil
      end
    else
      edit_admin_main_page_child_page_path(page.parent_page, page)
    end
  end

  def show_page_path(page)
    if page.special_page?
      polymorphic_path(page.key.classify.constantize)
    else
      main_page_path(page)
    end
  end

  def in_special_pages_menu
    params[:controller] == 'admin/key_numbers' ||
    params[:controller] == 'admin/staff_members' ||
    params[:controller] == 'admin/adherents'

  end

end
