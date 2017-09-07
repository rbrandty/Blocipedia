class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def index
    @wikis = Wiki.all
  end

  def show
  end

  def create
    @wiki = Wiki.new(wiki_params)
@wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:notice] = "There was an error saving your post.  Errors: #{@wiki.errors.full_messages}"
      render :new
    end
  end

  def edit
    authorize @wiki
  end

  def update
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
    flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:notice] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:id])
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
