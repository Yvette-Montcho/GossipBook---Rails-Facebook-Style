# Contrôleur gérant la connexion et la déconnexion des utilisateurs
# Gère la session Rails : création (login) et destruction (logout)
# Routes couvertes : GET /login, POST /login, DELETE /logout
class SessionsController < ApplicationController

  # GET /login
  # Affiche le formulaire de connexion
  def new
    # Redirection si l'utilisateur est déjà connecté (évite l'accès inutile)
    redirect_to root_path, notice: "Vous êtes déjà connecté(e)." if logged_in?
  end

  # POST /login
  # Traite l'authentification de l'utilisateur
  def create
    # Recherche de l'utilisateur par email (normalisé en minuscules)
    # find_by retourne nil si aucun utilisateur trouvé (pas d'exception)
    user = User.find_by(email: params[:session][:email].to_s.downcase)

    # Double vérification :
    # 1) L'utilisateur existe bien en base
    # 2) Le mot de passe fourni correspond au hash stocké (méthode bcrypt)
    if user && user.authenticate(params[:session][:password])
      # Connexion réussie : stockage de l'id en session
      log_in(user)

      # Message de bienvenue
      flash[:success] = "Content de vous revoir, #{user.username} !"

      # Redirection vers la page d'accueil
      redirect_to root_path
    else
      # Échec : email inexistant ou mot de passe incorrect
      # flash.now : le message ne persiste que pour le render courant (pas de redirect)
      flash.now[:danger] = "Combinaison email / mot de passe invalide."

      # Réaffichage du formulaire de connexion avec le message d'erreur
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  # Déconnecte l'utilisateur en détruisant sa session
  def destroy
    # Suppression de l'identifiant utilisateur de la session Rails
    log_out

    # Message de confirmation de déconnexion
    flash[:info] = "Vous avez été déconnecté(e). À bientôt !"

    # Redirection vers la page d'accueil
    redirect_to root_path
  end

end
