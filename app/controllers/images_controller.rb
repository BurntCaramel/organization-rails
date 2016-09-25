class ImagesController < ApplicationController
  include OrganizationsHelper
  include ImagesHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :setup_imgix

  def index
    @items = @item_relationships
    @max_width = 200
  end

  def show
    @item = @item_relationships.find_by(item_sha_256: params[:sha256])
    @max_width = 550
  end

  def imgix
    @sha256 = params.fetch(:sha256)
    @width = params.fetch(:width, 1000)
    @height = params.fetch(:height, 1000)

    # Works for both html and json formats
    render layout: nil
  end

  private
    def set_tag
      @image_tag = @organization.image_tag
      @item_relationships = @image_tag.item_relationships if @image_tag.present?
    end
end
