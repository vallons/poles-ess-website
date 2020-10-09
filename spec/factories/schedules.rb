# frozen_string_literal: true

FactoryBot.define do

  factory :schedule do
    time_range {(Date.current+1.month..Date.current+1.month+2.hours)}
    # end_at Date.current+1.month+2.day

  end
end
