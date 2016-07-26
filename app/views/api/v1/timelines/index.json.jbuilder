json.feed_entries @feed_entries do |feed_entry|
  json.feed_entry_id           			feed_entry.id
  json.feed_name	               	  feed_entry.feed.feed_name
  json.feed_id        	           	feed_entry.feed_id
  json.feed_entry_title             feed_entry.title
  json.feed_entry_url  	           	feed_entry.feed_entry_url
  json.published      	           	feed_entry.published
  json.author                       feed_entry.author
  json.feed_entry_content           feed_entry.feed_entry_content
  json.feed_entry_image             feed_entry.feed_entry_images.first
  json.is_read                      feed_entry.is_read
  json.is_starred                   feed_entry.is_starred
  json.entry_id                     feed_entry.entry_id
  json.summary                      feed_entry.summary
end
