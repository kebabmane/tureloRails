class TureloAdmin::FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all.paginate(:page => params[:page], :per_page => 10)
    @feed  = Feed.new
    authorize current_user
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
      authorize current_user
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
    authorize current_user
  end

  # POST /feeds
  # POST /feeds.json
  def create

    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        FeedWorker.perform_async(@feed.id)
        format.html { redirect_to admin_feeds_path, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to admin_feeds_path, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to admin_feeds_path, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:user_id, :feed_name, :feed_url, :number_feed_entries, :feed_icon, :tag_list)
    end
end
