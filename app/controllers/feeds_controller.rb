class FeedsController < ApplicationController
  before_action :set_category, only: [:show, :index]
  impressionist

  # GET /feeds
  # GET /feeds.json
  def index
    if params[:search].present?
      @feeds = Feed.all.order("updated_at DESC").search(params[:search], suggest: true, page: params[:page], per_page: 10)
   else
      @feeds = @category.feeds.paginate(:page => params[:page], :per_page => 10)
   end
   respond_to do |format|
     format.html
     format.js
   end
  end


  def follow
    @feed = Feed.find(params[:feed])
    current_user.follow!(@feed)
    Notification.create(recipient: current_user, actor: current_user, action: "follow", notifiable: @feed)
  end

  def unfollow
    @feed = Feed.find(params[:feed])
    current_user.unfollow!(@feed)
    Notification.create(recipient: current_user, actor: current_user, action: "unfollow", notifiable: @feed)
  end

  def show
    @feed = Feed.friendly.find(params[:id])
    redirect_to feed_feed_entries_path(@feed.id), notice: 'here is your feed!'
  end


  def refresh_feed
    FeedFirstRunWorker.perform_async(params[:feed_id])
    respond_to do |format|
      format.html { redirect_to feed_feed_entries_path, notice: 'Feed was successfully created.' }
      format.js { redirect_to feed_feed_entries_path, notice: 'Feed was successfully created.' }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.friendly.find(params[:id])
    end

    def set_category
      @category = Category.friendly.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:user_id, :feed_name, :feed_url, :feed_entries, :tag_list)
    end
end
