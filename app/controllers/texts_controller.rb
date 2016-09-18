class TextsController < ApplicationController
  include OrganizationsHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :set_s3_client

  def index
    @item_relationships = @text_tag.item_relationships if @text_tag.present?

    @items = @item_relationships.map do |item_relationship|
      {
        sha256: item_relationship.item_sha_256,
        text: get_item_text(item_relationship.item_sha_256)
      }
    end
  end

  def get_item_text(sha256)
    begin
      get_object("sha256/#{sha256}").body.string
    rescue Aws::S3::Errors::NoSuchKey
      nil
    end
  end

  private
    def set_tag
      @text_tag = @organization.text_tag
    end
end
