class TagsController < ApplicationController
  include OrganizationsHelper

  before_action :set_parent_organization
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = @organization.tags
  end

  def show
    @item_relationships = @tag.item_relationships.reject(&:new_record?)
    @new_item_relationship = @tag.item_relationships.build
  end

  def new
    @tag = @organization.tags.build
  end

  def create
    @tag = @organization.tags.build(tag_params)

    respond_to do |format|
      begin
        @tag.save!
        format.html { redirect_to [@organization, @tag], notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      rescue ActiveRecord::RecordNotUnique => e
        format.html {
          flash.alert = "Tag with name #{@tag.name} already exists."
          render :new
        }
        format.json { render json: [e], status: :unprocessable_entity }
      end
    end
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
