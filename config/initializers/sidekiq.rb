## For more details refer to: http://tsamni.com/post/84515089035/sidekiq-performing-background-or-delayed-jobs-with
# config/initializers/sidekiq.rb
rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

schedule_file = "config/schedule.yml"
