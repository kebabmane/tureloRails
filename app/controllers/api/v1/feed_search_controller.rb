module Api
 module V1
  class FeedSearchController < Api::BaseController
   before_action :set_feed, only: [:show, :edit, :update, :destroy]



  def autocomplete
   render json: FeedEntry.search(params[:query], fields: [{ title: :word_start }], limit: 10).map do |feed_entry|
      { feed_entry_name: feed_entry.title, feed_entry_id: feed_entry.id }
   end
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
