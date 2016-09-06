class DashboardController < ApplicationController
  before_action :require_current_user

  def index
    @callback_url = "#{ root_url }auth/auth0/callback"
  end
end
