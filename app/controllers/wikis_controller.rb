class WikisController < ApplicationController

  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @user = User.find(current_user.id)
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = @user.id

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki.  Please try again."
      redirect_to :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the wiki.  Please try again."
      redirect_to :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.new[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end


  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
