json.category @categories do |category|
  json.category_id           			category.id
  json.category_name	            category.category_name
  json.feeds_count                category.feeds_count
  json.updated_at                 category.updated_at
  json.category_image_url         category.category_image_url.url(:medium)
  json.category_description       category.category_description
end
