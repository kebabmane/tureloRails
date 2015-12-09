class FeedEntryImagesController < ApplicationController
  before_action :set_feed_entry_image, only: [:show, :edit, :update, :destroy]

  # GET /feed_entry_images
  # GET /feed_entry_images.json
  def index
    @feed_entry_images = FeedEntryImage.all
  end

  # GET /feed_entry_images/1
  # GET /feed_entry_images/1.json
  def show
  end

  # GET /feed_entry_images/new
  def new
    @feed_entry_image = FeedEntryImage.new
  end

  # GET /feed_entry_images/1/edit
  def edit
  end

  # POST /feed_entry_images
  # POST /feed_entry_images.json
  def create
    @feed_entry_image = FeedEntryImage.new(feed_entry_image_params)

    respond_to do |format|
      if @feed_entry_image.save
        format.html { redirect_to @feed_entry_image, notice: 'Feed entry image was successfully created.' }
        format.json { render :show, status: :created, location: @feed_entry_image }
      else
        format.html { render :new }
        format.json { render json: @feed_entry_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_entry_images/1
  # PATCH/PUT /feed_entry_images/1.json
  def update
    respond_to do |format|
      if @feed_entry_image.update(feed_entry_image_params)
        format.html { redirect_to @feed_entry_image, notice: 'Feed entry image was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed_entry_image }
      else
        format.html { render :edit }
        format.json { render json: @feed_entry_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_entry_images/1
  # DELETE /feed_entry_images/1.json
  def destroy
    @feed_entry_image.destroy
    respond_to do |format|
      format.html { redirect_to feed_entry_images_url, notice: 'Feed entry image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_entry_image
      @feed_entry_image = FeedEntryImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_entry_image_params
      params.require(:feed_entry_image).permit(:feed_entry_id, :img_url)
    end
end
