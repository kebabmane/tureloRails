# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  message    :text
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :announcement do
    message "MyText"
    starts_at "2016-07-06 19:56:20"
    ends_at "2016-07-06 19:56:20"
  end
end
