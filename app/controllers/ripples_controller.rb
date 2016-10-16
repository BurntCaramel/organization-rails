class RipplesController < ApplicationController
  include OrganizationsHelper
  include ChannelsHelper

  before_action :set_parent_organization
  before_action :set_parent_channel

  def create
    info = ripple_params.transform_keys do |key|
      s = key.to_s
      case s
      when 'item_sha256' then 'sha256'
      else s
      end
    end
    @ripple = @channel.ripples.build(info: info)

    @ripple.save

    redirect_to [@organization, @channel]
  end

  def destroy
    @ripple = @channel.ripples.find params[:id]
    @successor = @ripple.succeed_with delete: true
    @successor.save
  end

  def index
    @ripples = @channel.ripples.by_key_64 params[:key_base64]
  end

  private

    def ripple_params
      params.require(:ripple).permit(:name, :item_sha256)
    end
end
