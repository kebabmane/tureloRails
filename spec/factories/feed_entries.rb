# == Schema Information
#
# Table name: feed_entries
#
#  id                           :integer          not null, primary key
#  feed_id                      :integer
#  title                        :string
#  feed_entry_url               :string
#  published                    :datetime
#  author                       :string
#  feed_entry_content           :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  is_read                      :boolean
#  keep_unread                  :boolean
#  is_starred                   :boolean
#  entry_id                     :text
#  summary                      :text
#  likees_count                 :integer          default(0)
#  impressions_count            :integer
#  mentioners_count             :integer          default(0)
#  mentionees                   :integer          default(0)
#  likers_count                 :integer          default(0)
#  feed_entry_images_count      :integer          default(0)
#  summary_sanitized            :text
#  feed_entry_content_sanitized :text
#  disabled                     :boolean
#  comments_count               :integer          default(0), not null
#  upvotes_count                :integer          default(0), not null
#  downvotes_count              :integer          default(0), not null
#  score                        :integer          default(0), not null
#  rank                         :integer          default(0), not null
#

FactoryGirl.define do
  factory :feed_entry do
    feed nil
title "MyString"
feed_entry_url "MyString"
published "2015-12-05 17:29:47"
author "MyString"
feed_entry_content "MyString"
  end

end
