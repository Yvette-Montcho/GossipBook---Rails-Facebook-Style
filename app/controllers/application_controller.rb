# Contrôleur parent dont héritent TOUS les contrôleurs de GossipBook
# Centralise : inclusion des helpers communs, protection CSRF, méthode d'authentification
class ApplicationController < ActionController::Base

  # Inclusion du module SessionsHelper dans tous les contrôleurs ET toutes les vues
  # Rend disponibles partout : current_user, logged_in?, log_in, log_out
  include SessionsHelper

  # Protection CSRF (Cross-Site Request Forgery) : Rails vérifie le token d'authenticité
  # sur chaque requête POST/PATCH/PUT/DELETE pour éviter les attaques par formulaire
  protect_from_forgery with: :exception

  private

  # Filtre d'authentification : vérifie qu'un utilisateur est connecté
  # À appeler via before_action dans les contrôleurs qui nécessitent une connexion
  # Exemple : before_action :authenticate_user!, only: [:new, :create]
  def authenticate_user!
    # Si aucun utilisateur n'est connecté (session[:user_id] est nil)
    unless logged_in?
      # Message d'alerte affiché à l'utilisateur
      flash[:danger] = "Vous devez être connecté(e) pour effectuer cette action."
      # Redirection vers la page de connexion
      redirect_to login_path
    end
  end

end
