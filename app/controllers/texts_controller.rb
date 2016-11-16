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
    body = request.body
    content = body.read
    @new_item_relationship.item_sha_256 = upload_item body
    @new_item_relationship.save
  end
end
