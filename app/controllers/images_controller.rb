class ImagesController < ApplicationController
  include OrganizationsHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_s3_client
  before_action :set_tag
  before_action :setup_imgix

  IMAGE_MAX_WIDTH = 200
  IMGIX_HOST = 's-royalicing-test.imgix.net'

  def index
    if @image_tag.present?
      @item_relationships = @image_tag.item_relationships

      @items = @item_relationships.map do |item_relationship|
        {
          sha256: item_relationship.item_sha_256#,
          #text: get_item_text(item_relationship.item_sha_256)
        }
      end
    end
  end

  def render_image(sha256)
    url = @imgix.path("/#{ sha256 }").to_url(w: IMAGE_MAX_WIDTH)
    view_context.image_tag(url)
  end
  helper_method :render_image

  private
    def set_tag
      @image_tag = @organization.image_tag
    end

    def setup_imgix
      @imgix = Imgix::Client.new(host: IMGIX_HOST)
    end
end
