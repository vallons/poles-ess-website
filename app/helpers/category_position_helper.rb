# frozen_string_literal: true
module CategoryPositionHelper
  def categorized_max_position(params, scope)
    return 1 unless active_category_filter?(params)
    return staff_member_max_position(scope) if staff_member_category_filter?(params)
  end

  def active_category_filter?(params)
    staff_member_category_filter?(params)
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
end