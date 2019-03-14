class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    Tag.create!(tags_params)
    flash[:success] = 'Tag successfully created'
    redirect_to tags_path
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy!
    flash[:success] = 'Tag successfully removed'
    redirect_to tags_path
  end

  private

  def tags_params
    params.require(:tag).permit(:name)
  end
end
