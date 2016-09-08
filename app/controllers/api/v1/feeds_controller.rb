module Api
 module V1
   class FeedsController < Api::BaseController
   before_filter :authenticate_user!

  respond_to :json

  # GET /feeds
  # GET /feeds.json
  def index
      @feeds = Feed.all.order("updated_at DESC")
  end

  def autocomplete
   render json: Feed.search(params[:query], fields: [{ feed_name: :word_start }], track: true, limit: 10).map do |feed|
      { feed_name: feed.feed_name, feed_id: feed.id }
   end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end


  def follow
    @feed = Feed.find(params[:feed])
    current_user.follow!(@feed)
  end

  def unfollow
    @feed = Feed.find(params[:feed])
    current_user.unfollow!(@feed)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:user_id, :feed_name, :feed_url, :feed_entries, :tag_list)
    end
end
end
end
