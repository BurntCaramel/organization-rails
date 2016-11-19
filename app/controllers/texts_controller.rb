class TextsController < ApplicationController
  include AssetsControllerConcern
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :set_item_relationships
  before_action :set_item_relationship, only: [:show]
  before_action :set_new_item_relationship, only: [:index, :create]

  def tag_name
    TEXT_TAG
  end

  def index
  end

  def show
  end

  def new
  end

  def create
    #body = request.body
    #content = body.read
    content = params.require(:write_text).fetch(:content)
    s3_client = @organization.s3_client
    @new_item_relationship.item_sha_256 = s3_client.upload_item content
    @new_item_relationship.save

    redirect_to texts_path
  end
end
