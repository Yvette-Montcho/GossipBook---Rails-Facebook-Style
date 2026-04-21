# Contrôleur gérant la création des commentaires (imbriqué dans gossips)
# Route couverte : POST /gossips/:gossip_id/comments
class CommentsController < ApplicationController

  # L'utilisateur doit être connecté pour poster un commentaire
  before_action :authenticate_user!

  # POST /gossips/:gossip_id/comments
  # Crée un nouveau commentaire sur un potin
  def create
    # Récupération du potin parent grâce au gossip_id présent dans l'URL
    @gossip = Gossip.find(params[:gossip_id])

    # Construction du commentaire avec les paramètres filtrés
    @comment = Comment.new(comment_params)

    # Association du commentaire au potin et à l'utilisateur connecté
    @comment.gossip = @gossip
    @comment.user   = current_user

    # Tentative de sauvegarde
    if @comment.save
      flash[:success] = "Commentaire ajouté !"
    else
      # En cas d'erreur de validation, affichage du message d'erreur
      flash[:danger] = @comment.errors.full_messages.join(", ")
    end

    # Redirection vers la page du potin dans tous les cas (succès ou échec)
    redirect_to @gossip
  end

  private

  # Strong parameters pour les commentaires
  # Seul l'attribut :content est autorisé (user et gossip assignés manuellement)
  def comment_params
    params.require(:comment).permit(:content)
  end

end
