class ChannelsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = @organization.channels
  end

  def show
    @ripples = @channel.ripples
  end

  def new
    @channel = @organization.channels.build
  end

  def create
    @channel = @organization.channels.build(channel_params)

    respond_to do |format|
      begin
        @channel.save!
        format.html { redirect_to [@organization, @channel], notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "Channel with name #{@channel.name} already exists."
          render :new
        }
        format.json { render json: [e], status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @channel.destroy
    redirect_to organization_channels_path(@organization)
  end

  private

    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name)
    end

end
