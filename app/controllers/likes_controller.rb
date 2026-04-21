# Contrôleur gérant les likes et dislikes sur les potins
# Routes couvertes : POST /gossips/:gossip_id/likes
#                   DELETE /gossips/:gossip_id/likes/:id
class LikesController < ApplicationController

  # L'utilisateur doit être connecté pour liker ou déliker
  before_action :authenticate_user!

  # POST /gossips/:gossip_id/likes
  # Ajoute un like de l'utilisateur connecté sur un potin
  def create
    # Récupération du potin à liker via l'id dans l'URL
    @gossip = Gossip.find(params[:gossip_id])

    # Vérification : l'utilisateur n'a pas déjà liké ce potin
    if @gossip.liked_by?(current_user)
      flash[:warning] = "Vous avez déjà liké ce potin."
    else
      # Création du like associé au potin et à l'utilisateur connecté
      @gossip.likes.create!(user: current_user)
      flash[:success] = "❤️ Vous avez liké ce potin !"
    end

    # Redirection vers la page d'origine (HTTP_REFERER)
    # fallback_location : si le referer est absent, on retourne à l'accueil
    redirect_back fallback_location: root_path
  end

  # DELETE /gossips/:gossip_id/likes/:id
  # Retire le like de l'utilisateur connecté sur un potin
  def destroy
    # Récupération du potin
    @gossip = Gossip.find(params[:gossip_id])

    # Recherche du like appartenant à l'utilisateur connecté seulement
    # Sécurité : on ne peut supprimer QUE son propre like (find_by retourne nil si absent)
    @like = @gossip.likes.find_by(id: params[:id], user: current_user)

    if @like
      # Suppression du like
      @like.destroy
      flash[:success] = "Like retiré."
    else
      # Cas improbable : like introuvable ou n'appartient pas à l'utilisateur
      flash[:danger] = "Like introuvable."
    end

    # Redirection vers la page d'origine
    redirect_back fallback_location: root_path
  end

end
