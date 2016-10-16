class S3CredentialsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :create_new_s3_credential, only: [:new, :create]
  before_action :set_s3_credential, only: [:show, :edit, :update, :destroy]

  def index
    @s3_credentials = @organization.s3_credentials
  end

  def show
  end

  def new
  end

  def create
    params = s3_credential_params
    @s3_credential.info = {
      'accessKeyID' => params[:access_key_id],
      'secretAccessKey' => params[:secret_access_key],
      'region' => params[:region]
    }

    respond_to do |format|
      begin
        @s3_credential.save!
        format.html { redirect_to [@organization, @s3_credential], notice: 'S3 Credential was successfully added.' }
        format.json { render :show, status: :created, location: @s3_credential }
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "S3 Credential with access key id #{@s3_credential.access_key_id} already exists."
          render :new
        }
        format.json { render json: [e], status: :unprocessable_entity }
      rescue
        format.html { render :new }
        format.json { render :new }
      end
    end
  end

  def destroy
    @s3_credential.destroy
    redirect_to organization_s3_credentials_path(@organization)
  end

  private
    def s3_credential_params
      params.require(:s3_credential).permit(:access_key_id, :secret_access_key, :region)
    end

    def create_new_s3_credential
      @s3_credential = @organization.s3_credentials.build(info: {})
    end

    def set_s3_credential
      @s3_credential = @organization.s3_credentials.find_by(id: params[:id])
    end
end
