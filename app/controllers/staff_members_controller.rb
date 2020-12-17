class StaffMembersController < ApplicationController
  include SlugsAndRedirections

  before_action :set_breadcrumbs

  def index
    @staff_member_categories = StaffMemberCategory.having_staff_members.includes(:staff_members).order(:position)
  end

  private # =====================================================

  def get_staff_member
    @staff_member = get_object_from_param_or_redirect(StaffMember)
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",    root_path ]
    @breadcrumbs << [ "Le pôle",    main_page_path(MainPage.find_by(title: "Le pôle")) ]
    @breadcrumbs << [ "Equipe",      staff_members_path ]
  end
end
