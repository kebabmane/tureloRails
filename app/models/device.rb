# == Schema Information
#
# Table name: devices
#
#  id               :integer          not null, primary key
#  device_id        :integer
#  user_id          :integer
#  registration_id  :string
#  device_guid      :integer
#  device_os        :string
#  created_at       :datetime         not null
#  osVersion        :string
#  device_time_zone :datetime
#  sdkVersion       :string
#  device_name      :string
#  updated_at       :datetime         not null
#

class Device < ActiveRecord::Base

  belongs_to :user
	validates :registration_id, uniqueness: true

end
