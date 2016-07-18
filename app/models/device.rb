class Device < ActiveRecord::Base

  belongs_to :user
	validates :registration_id, uniqueness: true

end
