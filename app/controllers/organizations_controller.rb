class OrganizationsController < ApplicationController
  before_action :require_current_user
  before_action :create_new_organization, only: [:new, :create]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  include SessionsHelper
  include DashboardHelper

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.where(owner_identifier: current_user_identifier)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @item_tag_relationships = @organization.item_tag_relationships
  end

  # GET /organizations/new
  def new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization.assign_attributes(organization_params)
    @user_organization_capability = UserOrganizationCapability.new(
      organization: @organization,
      user: @current_user,
      capabilities: :admin
    )

    respond_to do |format|
      begin
        @organization.save!
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "Organization with name #{@organization.name} already exists."
          render :new
        }
        format.json { render json: [e], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      begin
        @organization.update! organization_params
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "Organization with name #{@organization.name} already exists." 
          render :edit
        }
        format.json { render json: [e], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end

    redirect_to_dashboard
  end

  private
    def set_organization
      @organization = Organization.find_by(id: params[:id], owner_identifier: current_user_identifier)
      redirect_to(organizations_url, alert: 'You are not a part of this organization.') if @organization.nil?
    end

    def create_new_organization
      @organization = Organization.new(owner_identifier: current_user_identifier)
    end

    def organization_params
      params.require(:organization).permit(:name)
    end
end
