class StoriesController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_tag

  def index
    @item_relationships = @story_tag.item_relationships if @story_tag.present?
    @script_flambe = true
  end

  private
    def set_tag
      @story_tag = @organization.story_tag
    end
end
