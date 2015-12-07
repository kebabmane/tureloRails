class OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_overview, only: [:show, :edit, :update, :destroy]


end
