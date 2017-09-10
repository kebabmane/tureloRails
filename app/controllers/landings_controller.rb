class LandingsController < ApplicationController
  layout "landing"
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized,  except: [:index, :show]
  impressionist


end
