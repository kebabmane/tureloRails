# == Schema Information
#
# Table name: categories
#
#  id                   :integer          not null, primary key
#  category_name        :string
#  feed_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_image_url   :string
#  category_description :string
#  feeds_count          :integer
#  slug                 :string
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
