class OrganizationInvitationsController < ApplicationController
  include OrganizationsHelper

  before_action :require_current_user
  before_action :set_parent_organization
  before_action :require_can_invite
  before_action :set_organization_invitation, only: [:destroy]
  before_action :set_new_organization_invitation, only: [:index, :create]

  # GET /organization_invitations
  # GET /organization_invitations.json
  def index
    @organization_invitations = OrganizationInvitation.where(organization: @organization)
  end

  # GET /organization_invitations/new
  def new
    @organization_invitation = OrganizationInvitation.new
  end

  # POST /organization_invitations
  # POST /organization_invitations.json
  def create
    @new_organization_invitation.assign_attributes(organization_invitation_params)

    capabilities_params = params.require(:organization_invitation).require(:capabilities)
    capabilities = [:member].concat capabilities_params.select(&:present?) 
    @new_organization_invitation.capabilities = capabilities

    #debugger

    respond_to do |format|
      if @new_organization_invitation.save
        format.html { redirect_to organization_invitations_url(@organization), notice: 'Organization invitation was successfully created.' }
        format.json { render :show, status: :created, location: organization_invitations_url(@organization) }
      else
        index
        format.html { render :index }
        format.json { render json: @new_organization_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_invitations/1
  # DELETE /organization_invitations/1.json
  def destroy
    @organization_invitation.destroy
    respond_to do |format|
      format.html { redirect_to organization_invitations_url(@organization), notice: 'Organization invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def require_can_invite
      redirect_to @organization, alert: 'You are not allowed to invite others' unless @user_organization_capability.invite?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_organization_invitation
      @organization_invitation = OrganizationInvitation.find(params[:id])
    end

    def set_new_organization_invitation
      @new_organization_invitation = OrganizationInvitation.new(organization: @organization)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_invitation_params
      params.require(:organization_invitation).permit(:email)
    end
end
