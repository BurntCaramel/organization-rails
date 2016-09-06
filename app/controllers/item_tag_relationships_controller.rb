class ItemTagRelationshipsController < ApplicationController
  def create
    tag = Tag.find(params[:tag_id])
    relationship = tag.item_relationships.create(item_tag_relationship_params)

    redirect_to [tag.organization, tag]
  end

  def destroy

  end

  private
    def item_tag_relationship_params
      params.require(:item_tag_relationship).permit(:item_sha_256)
    end
end
