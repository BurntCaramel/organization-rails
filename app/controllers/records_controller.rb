class RecordsController < ApplicationController
  include OrganizationsHelper
  include S3Helper

  before_action :set_parent_organization
  before_action :set_s3_client
  before_action :set_tag

  def index
    @item_relationships = @record_tag.item_relationships if @record_tag.present?

    @items = @item_relationships.map do |item_relationship|
      sha256 = item_relationship.item_sha_256
      {
        sha256: sha256,
        tag_relationships: @organization.tag_relationships_for_item(sha256),
        text: get_item_text(sha256)
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
      @record_tag = @organization.record_tag
    end
end
