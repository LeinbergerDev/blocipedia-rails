class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.wiki_id = @wiki.id
    @collaborator.user_id = params[:user_id]

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "Error adding collaborator to wiki.  Please try again."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])

    @collaborator = Collaborator.find_by(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator's access has been revoked."
      redirect_to edit_wiki_path
    else
      flash[:alert] = "Calloborator was not removed.  Please try again."
      redirect_to edit_wiki_path
    end
  end

end
