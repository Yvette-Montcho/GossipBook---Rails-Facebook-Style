# Contrôleur gérant l'inscription des nouveaux utilisateurs
# Routes couvertes : GET /signup (new) et POST /signup (create)
class UsersController < ApplicationController

  # GET /signup
  # Affiche le formulaire d'inscription
  def new
    # Initialisation d'un objet User vide pour lier le formulaire ERB
    @user = User.new
  end

  # POST /signup
  # Traite la soumission du formulaire d'inscription
  def create
    # Construction du nouvel utilisateur avec les paramètres filtrés (strong parameters)
    @user = User.new(user_params)

    # Tentative de sauvegarde en base de données
    if @user.save
      # Connexion automatique après inscription réussie (UX : pas de double login)
      log_in(@user)

      # Message de bienvenue personnalisé
      flash[:success] = "Bienvenue sur GossipBook, #{@user.username} ! 🎉"

      # Redirection vers la page d'accueil
      redirect_to root_path
    else
      # Échec de validation : réaffichage du formulaire avec les erreurs
      # status 422 : Unprocessable Entity (convention Rails 7)
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters : liste blanche des attributs acceptés pour User
  # Protège contre l'injection de masse (mass assignment vulnerability)
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
