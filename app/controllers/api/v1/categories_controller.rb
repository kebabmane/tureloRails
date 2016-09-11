module Api
 module V1
   class CategoriesController < Api::BaseController
   before_filter :authenticate_user!

  respond_to :json

  # GET /feeds
  # GET /feeds.json
  def index
      @categories = Category.all
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category, :feeds_id)
    end
end
end
end
