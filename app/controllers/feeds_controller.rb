class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index

    @feed  = Feed.new

    if params[:search].present?
      @feeds = Feed.all.order("updated_at DESC").search(params[:search], suggest: true, track: true, page: params[:page], per_page: 9)
   else
      @feeds = Feed.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 9)
   end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  def follow
    @feed = Feed.find(params[:feed])
    current_user.follow!(@feed)
  end

  def unfollow
    @feed = Feed.find(params[:feed])
    current_user.unfollow!(@feed)
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        FeedWorker.perform_async(@feed.id)
        format.html { redirect_to feeds_path, notice: 'Feed was successfully created, please wait whilst we populate data' }
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
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
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
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def refresh_feed
    FeedEntryFirstRunWorker.perform_async(params[:feed_id])

    respond_to do |format|
      format.html { redirect_to feed_feed_entries_path, notice: 'Feed was successfully created.' }
      format.js { redirect_to feed_feed_entries_path, notice: 'Feed was successfully created.' }
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
