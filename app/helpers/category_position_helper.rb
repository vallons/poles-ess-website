# frozen_string_literal: true
module CategoryPositionHelper
  def categorized_max_position(params, scope)
    return 1 unless active_category_filter?(params)
    return staff_member_max_position(scope) if staff_member_category_filter?(params)
    return adherent_max_position(scope) if adherent_category_filter?(params)
    return partner_max_position(scope) if partner_category_filter?(params)
  end

  def active_category_filter?(params)
    staff_member_category_filter?(params) || adherent_category_filter?(params) || partner_category_filter?(params)
  end

  protected

  # Staff Member Category ===================================

  def staff_member_max_position(scope)
    scope.by_staff_member_category(staff_member_category).map(&:position).compact.max
  end

  def staff_member_category_filter?(params)
    params[:by_staff_member_category].present?
  end

  def staff_member_category
    StaffMemberCategory.find(params[:by_staff_member_category])
  end

  # Adherent Category ===================================

  def adherent_max_position(scope)
    scope.by_adherent_category(adherent_category).map(&:position).compact.max
  end

  def adherent_category_filter?(params)
    params[:by_adherent_category].present?
  end

  def adherent_category
    AdherentCategory.find(params[:by_adherent_category])
  end

  # Partenaire Category ===================================

  def partner_max_position(scope)
    scope.by_partner_category(partner_category).map(&:position).compact.max
  end

  def partner_category_filter?(params)
    params[:by_partner_category].present?
  end

  def partner_category
    AdherentCategory.find(params[:by_partner_category])
  end
end