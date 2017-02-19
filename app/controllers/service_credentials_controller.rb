class ServiceCredentialsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_service_credential, only: [:edit, :create, :update, :destroy]

  def index
    @kinds = ServiceCredential::KINDS
    @service_credentials = @organization.service_credentials
  end

  def edit
    @id = params[:id]
    @scripts_urls = []
    @scripts_inline = []

    if @id === "trello"
      @scripts_urls << "https://trello.com/1/client.js?key=#{ ENV.fetch('TRELLO_KEY') }"
      @scripts_inline << "
$('#service_credential_info_token').val('dfgdfgd');
Trello.authorize({
  type: 'popup',
  name: 'Royal Icing',
  scope: {
    read: 'true',
    write: 'true' },
  expiration: 'never',
  success: function() {
    $('#service_credential_info_token').val(Trello.token());
    console.log(Trello.token())
  },
  error: function() {

  }
});"
    end
  end

  def show
    redirect_to edit_organization_service_credential_url(@organization, params[:id])
  end

  def update
    @service_credential.info = service_credential_info_params.to_h

    respond_to do |format|
      begin
        @service_credential.save!
        format.html { redirect_to edit_organization_service_credential_url(@organization, @service_credential.kind), notice: 'Service Credential was successfully updated.' }
        format.json { render :edit, status: :created, location: @service_credential } # FIXME, no :show
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "Service Credential with kind #{@service_credential.kind} already exists."
          render :edit
        }
        format.json { render json: [e], status: :unprocessable_entity }
      rescue
        format.html { render :edit }
        format.json { render :edit }
      end
    end
  end

  def create
    update
  end

  def destroy
    @service_credential.destroy
    redirect_to organization_service_credentials_path(@organization)
  end

  private
    def service_credential_info_params
      params.require(:service_credential).require(:info).permit(*@service_credential.info_keys)
    end

    def set_service_credential
      @service_credential = @organization.service_credentials.find_by(kind: params[:id])
      @service_credential = @organization.service_credentials.build(kind: params[:id], info: {}) if @service_credential.nil?
    end
end
