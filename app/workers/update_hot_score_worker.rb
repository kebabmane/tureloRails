class UpdateHostScoreWorker
  include Sidekiq::Worker

  def perform
    FeedEntry.find_each do |feed|
      feed.touch
    end
  end

end
