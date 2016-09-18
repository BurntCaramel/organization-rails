class TextsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_tag

  def index
    @item_relationships = @text_tag.item_relationships if @text_tag.present?
  end

  private
    def set_tag
      @text_tag = @organization.text_tag
    end
end
