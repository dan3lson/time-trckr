class TagsController < ApplicationController
  before_action :require_login

  def index
    @tags = current_user.tags.a_to_z
  end

  def new
    @tag = Tag.new
  end

  def create
    raise ActiveRecord::RecordInvalid if tags_params[:name].blank?

    @new_tags = Tag.initializer(current_user, tags_params[:name])
    Tag.transaction do
      @new_tags.each(&:save!)
    end
    flash[:success] = 'Tags successfully created'
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
