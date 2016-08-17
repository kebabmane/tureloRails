namespace :tag_cleaner do
  desc "delete unused tags"
  task :delete_unused => :environment do
    ActsAsTaggableOn::Tag.joins(
      "LEFT JOIN taggings on taggings.tag_id = tags.id").where("taggings.id is null").delete_all
    ActsAsTaggableOn::Tagging.joins(
      "LEFT JOIN tags on tags.id = taggings.tag_id").where("tags.id is null").delete_all
  end
end
