class TextsController < ApplicationController
  include OrganizationsHelper
  include TextsHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :set_s3_client

  def index
    @items = @item_relationships
  end

  def show
    @item = @item_relationships.find_by(item_sha_256: params[:sha256])
  end

  def new
  end

  def create
    body = request.body
    sha256 = upload_item body
  end

  private
    def set_tag
      @text_tag = @organization.text_tag
      @item_relationships = @text_tag.item_relationships if @text_tag.present?
    end
end
