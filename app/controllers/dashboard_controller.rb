class DashboardController < ApplicationController
  before_action :set_current_user

  def index
    @callback_url = "#{ root_url }auth/auth0/callback"
  end

  private
    def set_current_user
      @current_user = session[:current_user]
    end
end
