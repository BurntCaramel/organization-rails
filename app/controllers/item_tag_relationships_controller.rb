class ItemTagRelationshipsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization

  def create
    @tag = @organization.tags.find(params[:tag_id])
    @relationship = @tag.item_relationships.build(item_tag_relationship_params)

    respond_to do |format|
      begin
        @relationship.save!
        format.html { redirect_to [@tag.organization, @tag], notice: 'Item was successfully tagged.' }
        format.json { render json: { success: true }, status: :created, location: @tag }
      rescue ActiveRecord::RecordNotUnique => e
        format.html { redirect_to [@tag.organization, @tag], alert: "Item has already been tagged ##{@tag.name}." }
        format.json { render json: [e], status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @relationship = @organization.item_tag_relationships.find(params[:id])
    @relationship.destroy
  end

  private
    def item_tag_relationship_params
      params.require(:item_tag_relationship).permit(:item_sha_256)
    end
end
