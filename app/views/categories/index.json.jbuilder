json.array!(@categories) do |category|
  json.extract! category, :id, :category, :feeds_id
  json.url category_url(category, format: :json)
end
