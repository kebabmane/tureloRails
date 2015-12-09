json.array!(@feed_entry_images) do |feed_entry_image|
  json.extract! feed_entry_image, :id, :feed_entry_id, :img_url
  json.url feed_entry_image_url(feed_entry_image, format: :json)
end
