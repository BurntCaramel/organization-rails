class ImagesController < ApplicationController
  include AssetsControllerConcern
  include OrganizationsHelper
  include ImagesHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :set_item_relationships
  before_action :set_item_relationship, only: [:show]
  before_action :set_new_item_relationship, only: [:index, :create]
  before_action :setup_imgix
  before_action :set_s3_client, only: [:create]

  def tag_name
    IMAGE_TAG
  end

  def index
    @max_width = 200
  end

  def show
    @max_width = 550
  end

  def imgix
    @sha256 = params.fetch(:sha256)
    @width = params.fetch(:width, 1000)
    @height = params.fetch(:height, 1000)

    # Works for both html and json formats
    render layout: nil
  end

  def create
    body = request.body
    content = body.read
    upload_item content
  end
end
