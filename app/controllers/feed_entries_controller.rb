class FeedEntriesController < ApplicationController
  before_action :set_feed, only: [:index, :show]
  impressionist

  # GET /feed_entries
  # GET /feed_entries.json
  def index
    @feed_entries = @feed.feed_entries.order("published DESC").includes(:feed_entry_images).paginate(:page => params[:page], :per_page => 9)
    respond_to do |format|
      format.html
      format.js
    end

  end

  def like
      @likeable = FeedEntry.find(params[:feed_entry])
	    current_user.like!(@likeable)
      @likeable.feed.followers(User).each do |user|
        Notification.create(recipient: user, actor: user, action: "like", notifiable: @likeable)
      end
  end

  def unlike
       @likeable = FeedEntry.find(params[:feed_entry])
	     current_user.unlike!(@likeable)
       @likeable.feed.followers(User).each do |user|
         Notification.create(recipient: user, actor: user, action: "unlike", notifiable: @likeable)
       end
  end

  # GET /feed_entries/1
  # GET /feed_entries/1.json
  def show
    @feed_entry = FeedEntry.includes(:feed_entry_images).find(params[:id])
    @recent_feed = FeedEntry.includes(:feed_entry_images).all.order("published DESC").limit(5)
  end



  private

    def set_feed
      @feed = Feed.friendly.find(params[:feed_id])
    end

end
