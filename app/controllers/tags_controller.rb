class TagsController < ApplicationController
  before_action :require_login

  def index
    @tags = current_user.tags
  end

  def new
    @tag = Tag.new
  end

  def create
    current_user.tags.create!(tags_params)
    flash[:success] = 'Tag successfully created'
    redirect_to tags_path
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    @tag.destroy!
    flash[:success] = 'Tag successfully removed'
    redirect_to tags_path
  end

  private

  def tags_params
    params.require(:tag).permit(:name)
  end
end
