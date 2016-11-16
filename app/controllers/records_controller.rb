class RecordsController < ApplicationController
  include AssetsControllerConcern
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_tag
  before_action :set_item_relationships
  before_action :set_item_relationship, only: [:show]
  before_action :set_new_item_relationship, only: [:index, :create]

  def tag_name
    RECORD_TAG
  end

  def index
  end

  def show
  end
end
