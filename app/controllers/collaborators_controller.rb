class CollaboratorsController < ApplicationController
  def :new
    @Collaborator = Collaborator.new
  end

  def :create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:alert] = "Error adding collaborator to wiki.  Please try again."
    end
  end

  def :destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find_by(wiki_id: @wiki.id, user_id: params[:user_id])
  end
end
