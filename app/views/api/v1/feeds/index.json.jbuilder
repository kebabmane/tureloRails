json.feed @feeds do |feed|
  json.feed_id           			feed.id
  json.feed_name	            feed.feed_name
  json.feed_entries_count     feed.feed_entries_count
  json.updated_at             feed.updated_at
  json.feed_image_url         feed.feed_image_url
end
