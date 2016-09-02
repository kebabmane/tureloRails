class FeedEntriesController < ApplicationController
  before_action :set_feed, only: [:index, :show]
  before_action :set_category, only: [:show, :index]
  before_action :set_feed_entry, only: [:show]
  impressionist

  # GET /feed_entries
  # GET /feed_entries.json
  def index
    order = params[:newest] ? {rank: :desc} : {created_at: :desc}

    @feed_entries = @feed.feed_entries.order(order).includes(:feed_entry_images).paginate(:page => params[:page], :per_page => 9)
    @votes = @feed_entries.includes(:votes).each_with_object({}) do |feed_entry, object|
      object[feed_entry.id] = feed_entry.votes.map(&:user_id)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end


  # GET /feed_entries/1
  # GET /feed_entries/1.json
  def show
    #@feed_entry = FeedEntry.includes(:feed_entry_images).find(params[:id])
    @recent_feed = FeedEntry.includes(:feed_entry_images).all.order("published DESC").limit(5)
  end

  def popular_tags
    @tags = FeedEntry.tag_counts_on(:tags)
  end


  private

    def set_feed
      @feed = Feed.friendly.find(params[:feed_id])
    end

    def set_feed_entry
      @feed_entry = FeedEntry.includes(:votes).find(params[:id])
      @votes = [@feed_entry].each_with_object({}) do |feed_entry, object|
        object[feed_entry.id] = feed_entry.votes.map(&:user_id)
      end
    end

    def set_category
      @category = Category.friendly.find(params[:category_id])
    end
end
