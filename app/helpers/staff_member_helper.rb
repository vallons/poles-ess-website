# frozen_string_literal: true
module StaffMemberHelper
  def staff_member_category_options(staff_member_categories = StaffMemberCategory.all)
    staff_member_categories.order(title: :asc).map do |staff_member_category|
      [staff_member_category.title, staff_member_category.id]
    end
  end

  def staff_member_options(staff_members = StaffMember.all)
    staff_members.order(title: :asc).map do |staff_member|
      [staff_member.title, staff_member.id]
    end
  end
end
