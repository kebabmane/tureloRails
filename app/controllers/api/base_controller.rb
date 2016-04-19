module Api
  class BaseController < ApplicationController
    #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
    before_action :set_resource, only: [:destroy, :show, :update]
    respond_to :json
    impressionist actions: [:index]




 end
end
