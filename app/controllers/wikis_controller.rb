class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
    @collaborations = User.all - [current_user]
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.user = current_user
    @collaborations = User.all - [@wiki.user]
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Your Wiki has been created"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your Wiki, please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your Wiki has been created"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your Wiki, please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.delete
      flash[:notice] = "Your Wiki has been deleted"
      redirect_to request.referrer
    else
      flash.now[:alert] = "We couldn't delete your wiki, please try again."
      redirect_to request.referrer
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, user_ids: [])
  end
end
