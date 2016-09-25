class ImagesController < ApplicationController
  include OrganizationsHelper
  include ImagesHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :setup_imgix

  IMGIX_HOST = 's-royalicing-test.imgix.net'

  def index
    @items = @item_relationships
    @max_width = 200
  end

  def show
    @item = @item_relationships.find_by(item_sha_256: params[:sha256])
    @max_width = 550
  end

  private
    def set_tag
      @image_tag = @organization.image_tag
      @item_relationships = @image_tag.item_relationships if @image_tag.present?
    end

    def setup_imgix
      @imgix = Imgix::Client.new(host: IMGIX_HOST)
    end
end
