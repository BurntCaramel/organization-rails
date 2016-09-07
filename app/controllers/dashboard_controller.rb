class DashboardController < ApplicationController
  before_action :check_current_user

  def index
    @callback_url = "#{ root_url }auth/auth0/callback"
  end
end
