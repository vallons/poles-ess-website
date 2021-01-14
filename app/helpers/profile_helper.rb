# frozen_string_literal: true
module ProfileHelper
  def profile_options(profiles = Profile.all)
    profiles.order(title: :asc).map do |profile|
      [profile.title, profile.id]
    end
  end
end
