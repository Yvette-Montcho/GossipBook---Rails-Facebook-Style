# Contrôleur gérant le CRUD complet des potins
# Implémente toutes les 7 actions RESTful avec filtres de sécurité
class GossipsController < ApplicationController

  # ── Callbacks (before_action) ──────────────────────────────────────────────

  # Authentification requise avant ces actions : création, édition, suppression
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # Chargement automatique du potin depuis l'URL avant les actions qui en ont besoin
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]

  # Vérification que l'utilisateur connecté est bien l'auteur du potin
  # Appliqué avant édition et suppression uniquement
  before_action :authorize_author!, only: [:edit, :update, :destroy]

  # ── Actions RESTful ────────────────────────────────────────────────────────

  # GET /gossips
  # Affiche la liste de tous les potins (page d'accueil)
  def index
    # Chargement avec eager loading pour éviter les requêtes N+1
    # includes(:user, :city, ...) → Rails charge toutes les associations en 1 requête
    @gossips = Gossip.includes(:user, :city, :comments, :likes)
                     .order(created_at: :desc)
  end

  # GET /gossips/:id
  # Affiche le détail d'un potin avec ses commentaires
  def show
    # Accès restreint aux utilisateurs connectés
    authenticate_user!

    # Chargement des commentaires avec leurs auteurs, triés par date croissante
    @comments = @gossip.comments.includes(:user).order(created_at: :asc)

    # Objet Comment vide pour le formulaire d'ajout de commentaire
    @comment = Comment.new
  end

  # GET /gossips/new
  # Affiche le formulaire de création d'un nouveau potin
  def new
    # Objet Gossip vide pour lier le formulaire
    @gossip = Gossip.new

    # Liste des villes pour le menu déroulant (triées alphabétiquement)
    @cities = City.order(:name)
  end

  # POST /gossips
  # Traite la soumission du formulaire de création
  def create
    # Construction du potin avec les paramètres filtrés
    @gossip = Gossip.new(gossip_params)

    # Association automatique à l'utilisateur connecté (Fat model, skinny controller)
    @gossip.user = current_user

    # Tentative de sauvegarde
    if @gossip.save
      flash[:success] = "Potin publié avec succès ! 📢"
      # Redirection vers la page de détail du nouveau potin
      redirect_to @gossip
    else
      # Rechargement des villes pour réafficher le formulaire
      @cities = City.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  # GET /gossips/:id/edit
  # Affiche le formulaire de modification d'un potin existant
  def edit
    # @gossip déjà chargé par set_gossip et vérifié par authorize_author!
    @cities = City.order(:name)
  end

  # PATCH/PUT /gossips/:id
  # Traite la mise à jour d'un potin
  def update
    # Mise à jour avec les nouveaux paramètres filtrés
    if @gossip.update(gossip_params)
      flash[:success] = "Potin mis à jour avec succès !"
      redirect_to @gossip
    else
      @cities = City.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /gossips/:id
  # Supprime un potin (et en cascade : ses commentaires et likes)
  def destroy
    # Suppression du potin → déclenche dependent: :destroy sur comments et likes
    @gossip.destroy
    flash[:success] = "Potin supprimé."
    # Redirection vers la liste des potins
    redirect_to gossips_path
  end

  private

  # Charge le potin correspondant à l'id passé dans l'URL
  # Utilisé par les before_action set_gossip
  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  # Vérifie que l'utilisateur connecté est bien l'auteur du potin
  # Redirige avec erreur si quelqu'un tente de modifier le potin d'un autre
  def authorize_author!
    unless @gossip.user == current_user
      flash[:danger] = "Vous n'êtes pas autorisé(e) à modifier ce potin."
      redirect_to root_path
    end
  end

  # Strong parameters : liste blanche des attributs acceptés pour Gossip
  def gossip_params
    params.require(:gossip).permit(:title, :content, :city_id)
  end

end
