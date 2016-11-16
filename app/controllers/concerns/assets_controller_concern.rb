module AssetsControllerConcern
  extend ActiveSupport::Concern

  def set_tag
    @tag = @organization.tags.find_by name: tag_name
  end

  def set_item_relationships
    if @tag.nil?
      redirect_to new_organization_tag_path(@organization, name: tag_name)
      return
    end

    @item_relationships = @tag.item_relationships.all
    @items = @item_relationships.map(&:item)
    #@items = @item_relationships.to_a.lazy.map(&:item)
    # @items = Enumerator::Lazy.new(@item_relationships) do |yielder, *values|
    #   result = yield *values
    #   yielder << result.item
    # end
  end

  def set_item_relationship
    @item_relationship = @item_relationships.find_by(item_sha_256: params[:sha256])
    @item = @item_relationship.item
  end

  def set_new_item_relationship
    @new_item_relationship = @tag.item_relationships.build
  end
end