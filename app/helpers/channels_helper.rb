module ChannelsHelper
  include DashboardHelper

  def set_parent_channel
    @channel = @organization.channels.find_by(id: params[:channel_id]) 
    redirect_to(dashboard_url, alert: 'You are not a part of this channel.') if @channel.nil?
  end
end
